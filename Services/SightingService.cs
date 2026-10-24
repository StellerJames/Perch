using Dapper;
using MySqlConnector;
using Perch.Models;

namespace Perch.Services
{
    public class SightingService
    {
        private readonly string connectionString;
        //Same connection as BirdService (from user-secrets.)
        public SightingService(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("Perch") ?? throw new InvalidOperationException("Connection string 'Perch' not found. Add with Manage User Secrets.");
        }

        //Daily List: users sightings from today
        public async Task<List<Sighting>> GetTodayAsync(int userId)
        {
            using var connection = new MySqlConnection(connectionString);

            var sightings = await connection.QueryAsync<Sighting>("""
                SELECT s.sighting_id, s.user_id, s.bird_id, s.bird_count, s.seen_on, s.notes, b.common_name, b.latin_name
                FROM sightings s
                JOIN birds b ON b.bird_id = s.bird_id
                WHERE s.user_id = @UserId AND s.seen_on = CURDATE() /*returns current date*/
                ORDER BY s.sighting_id
                """,
                new { UserId = userId });
            return sightings.ToList();
        }

        //The + button: "I saw this many of this type of bird today."
        //MySQL fills in today's date by default since it's a "daily" list.

        public async Task AddAsync(int userId, int birdId, int birdCount)
        {
            using var connection = new MySqlConnection(connectionString);
            await connection.ExecuteAsync("""
                INSERT INTO sightings (user_id, bird_id, bird_count)
                VALUES (@UserId, @BirdId, @BirdCount)
                """,
                new { UserId = userId, BirdId = birdId, BirdCount = birdCount });
        }

        //Edit Form: change the count/species.
        //Checking user_id as well means that a user can only edit their own sightings.

        public async Task UpdateAsync(Sighting sighting)
        {
            using var connection = new MySqlConnection(connectionString);
            await connection.ExecuteAsync("""
                UPDATE sightings
                SET bird_id = @BirdId, bird_count = @BirdCount
                WHERE sighting_id = @SightingId AND user_id = @UserId
                """,
                sighting);
        }

        //Edit form's delete button
        public async Task DeleteAsync(int sightingId, int userId)
        {
            using var connection = new MySqlConnection(connectionString);

            await connection.ExecuteAsync("""
                DELETE FROM sightings
                WHERE sighting_id = @SightingId AND user_id = @UserId
                """,
                new { SightingId = sightingId, UserId = userId });
        }

    }
}
