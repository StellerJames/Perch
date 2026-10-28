using Dapper;
using MySqlConnector;
using Perch.Models;

namespace Perch.Services
{
    public class NemesisService
    {
        public readonly string connectionString;
        //Same connection as BirdService (from user secrets.)

        public NemesisService(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("Perch") ?? throw new InvalidOperationException("Connection string 'Perch' not found. Add with Manage User Secrets.");
        }
        //Nemesis List: birds the user has added as a nemesis but has NOT seen yet. 
        //NOT EXISTS skips any sighted birds, so the nemesis list automatically updates once a bird is sighted on the Life/Daily list.

        public async Task<List<Bird>>
        GetNemesisListAsync(int userId)
        {
            using var connection = new MySqlConnection(connectionString);
            var birds = await connection.QueryAsync<Bird>("""
                Select b.bird_id, b.common_name, b.latin_name, i.image_file 
                AS photo_file
                FROM nemesis_birds n
                JOIN birds b ON b.bird_id = n.bird_id
                LEFT JOIN images i ON i.bird_id = b.bird_id AND i.is_featured = 1
                WHERE n.user_id = @UserId
                AND NOT EXISTS (SELECT 1 FROM sightings s WHERE s.user_id = n.user_id AND s.bird_id = n.bird_id)
                ORDER BY b.common_name                
                """,
                new { UserId = userId });
            return birds.ToList();
        }

        //Add Nemesis button
        //INSERT IGNORE: if this bird is already in the nemesis list, do nothing.
        public async Task AddAsync(int userId, int birdId)
        {
            using var connection = new MySqlConnection(connectionString);
            await connection.ExecuteAsync("""
                INSERT IGNORE INTO nemesis_birds (user_id, bird_id)
                VALUES (@UserId, @BirdId)
                """,
                new { UserId = userId, BirdId = birdId });
        }

        //Remove Nemesis button (gives user option to remove a bird from their nemesis list)
        //user_id + bird_id identifies the row to delete.

        public async Task RemoveAsync(int userId, int birdId)
        {
            using var connection = new MySqlConnection(connectionString);
            await connection.ExecuteAsync("""
                DELETE FROM nemesis_birds
                WHERE user_id = @UserId AND bird_id = @BirdId
                """,
                new { UserId = userId, BirdId = birdId });
        }
    }
}

