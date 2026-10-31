using Dapper;
using MySqlConnector;
using Perch.Models;
using System.Collections.Concurrent;

namespace Perch.Services
{
    public class BirdService
    {
        private readonly string connectionString;

        //The connection string is located in user-secrets
        //(Manage User Secrets, located under Perch (right-click)),
        //under ConnectionStrings:Perch, so the password never goes in the project.
        public BirdService(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("Perch")
                ?? throw new InvalidOperationException(
                    "Connection string 'Perch' not found. Add it with Manage User Secrets.");
        }

        //Every bird query starts here: the bird, its family name, and its featured photo.
        private const string BirdSelect = """
            SELECT b.bird_id, b.common_name, b.latin_name, b.latin_pronunciation,
                   b.family_id, b.size_min_in, b.size_max_in, b.description,
                   f.name AS family_name,
                   i.image_file AS photo_file
            FROM birds b
            JOIN families f ON f.family_id = b.family_id
            LEFT JOIN images i ON i.bird_id = b.bird_id AND i.is_featured = 1
            """;

        public async Task<List<Bird>> GetAllAsync()
        {
            using var connection = new MySqlConnection(connectionString);
            var birds = await connection.QueryAsync<Bird>($"{BirdSelect} ORDER BY b.common_name");
            return birds.ToList();
        }

        //Search Perch: matches common or Latin name anywhere in the text.
        //An empty search returns every bird.
        public async Task<List<Bird>> SearchAsync(string searchText)
        {
            //Escape LIKE's wildcards so typing % or _ searches for that character
            var escaped = searchText.Trim()
                .Replace("\\", "\\\\").Replace("%", "\\%").Replace("_", "\\_");

            using var connection = new MySqlConnection(connectionString);
            var birds = await connection.QueryAsync<Bird>($"""
                {BirdSelect}
                WHERE b.common_name LIKE @Pattern OR b.latin_name LIKE @Pattern
                ORDER BY b.common_name
                """,
                new { Pattern = $"%{escaped}%" });
            return birds.ToList();
        }

        //Life List: Returns a complete list of birds that the user has logged sightings for.
        //Includes the total number of sightings for each bird, counted across all of their Daily List sightings.

        public async Task<List<Bird>> GetLifeListAsync(int userId)
        { 
        using var connection = new MySqlConnection(connectionString);
            var birds = await connection.QueryAsync<Bird>("""
                SELECT b.bird_id, b.common_name, b.latin_name, i.image_file AS photo_file, SUM(s.bird_count) AS total_count FROM sightings s
                JOIN birds b ON b.bird_id = s.bird_id
                LEFT JOIN images i on i.bird_id = b.bird_id AND i.is_featured = 1
                WHERE s.user_id = @UserId
                GROUP BY b.bird_id, b.common_name, b.latin_name, i.image_file
                ORDER BY b.common_name
                """,
                new { UserId = userId });
            return birds.ToList();
        }

        //Bird ID: every bird earns points for each answer it matches, and the best matches come first.
        //  +1 for each chosen color the bird has
        //  +2 if its size range overlaps the chosen size
        //  +1 if its size is close (within 3 inches) but not an exact fit
        //Birds that match nothing (score 0) are left out.
        public async Task<List<Bird>> IdentifyAsync(List<string> colors, decimal minIn, decimal maxIn, int? habitatTileId)
        {
            using var connection = new MySqlConnection(connectionString);
            var birds = await connection.QueryAsync<Bird>("""
                SELECT b.bird_id, b.common_name, b.latin_name, i.image_file AS photo_file,
                       (
                           (SELECT COUNT(*)
                            FROM bird_colors bc
                            JOIN colors c ON c.color_id = bc.color_id
                            WHERE bc.bird_id = b.bird_id AND c.name IN @Colors)
                           +
                           CASE
                               WHEN b.size_min_in <= @MaxIn AND b.size_max_in >= @MinIn THEN 2
                               WHEN b.size_min_in <= @MaxIn + 3 AND b.size_max_in >= @MinIn - 3 THEN 1
                               ELSE 0
                           END
                           +
                          COALESCE ((SELECT MAX(CASE WHEN
                          bh.is_primary = 1 THEN 2 ELSE 1 END)
                          FROM bird_habitats bh
                          JOIN habitats h ON
                          h.habitat_id = bh.habitat_id
                          WHERE bh.bird_id = b.bird_id 
                          AND h.tile_id = @HabitatTileId), 0)
                       ) AS match_score
                FROM birds b
                LEFT JOIN images i ON i.bird_id = b.bird_id AND i.is_featured = 1
                HAVING match_score > 0
                ORDER BY match_score DESC, b.common_name
                LIMIT 20
                """,
                new { Colors = colors, MinIn = minIn, MaxIn = maxIn, HabitatTileId = habitatTileId });
            return birds.ToList();
        }

        //Bird Profile: one bird with all its photos, colors and habitats.
        //QueryMultiple sends the four SELECTs in one trip to the database.
        public async Task<Bird?> GetByIdAsync(int birdId)
        {
            using var connection = new MySqlConnection(connectionString);
            using var results = await connection.QueryMultipleAsync($"""
                {BirdSelect} WHERE b.bird_id = @BirdId;

                SELECT i.image_id, i.bird_id, i.page_url, i.image_file, i.author, i.source, i.is_featured,
                       l.name AS license_name, l.url AS license_url, l.requires_attribution
                FROM images i
                JOIN licenses l ON l.license_id = i.license_id
                WHERE i.bird_id = @BirdId
                ORDER BY i.is_featured DESC, i.image_id;

                SELECT c.name
                FROM bird_colors bc
                JOIN colors c ON c.color_id = bc.color_id
                WHERE bc.bird_id = @BirdId
                ORDER BY c.sort_order;

                SELECT h.name
                FROM bird_habitats bh
                JOIN habitats h ON h.habitat_id = bh.habitat_id
                WHERE bh.bird_id = @BirdId
                ORDER BY bh.is_primary DESC, h.name;
                """,
                new { BirdId = birdId });

            var bird = await results.ReadSingleOrDefaultAsync<Bird>();
            if (bird is null) return null;

            bird.Images = (await results.ReadAsync<BirdImage>()).ToList();
            bird.Colors = (await results.ReadAsync<string>()).ToList();
            bird.Habitats = (await results.ReadAsync<string>()).ToList();
            return bird;
        }
    }
}
