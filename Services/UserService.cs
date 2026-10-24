using Dapper;
using MySqlConnector;
using Perch.Models;
using Microsoft.AspNetCore.Identity;

namespace Perch.Services
{
    public class UserService
    {
       //Creates password hasher
        private readonly PasswordHasher<User> hasher = new();
        
        //Same connection as SightingService (from user-secrets.)
        private readonly string connectionString;
        
        public UserService(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("Perch") ?? throw new InvalidOperationException("Connection string 'Perch' not found. Add with Manage User Secrets.");

        }

        public async Task<bool> CreateAsync(string username, string email, string password)
        {
            //Passwords are never stored as plain text, only the hash is stored in the database.
            var user = new User { Username = username, Email = email };
            //Hash the password and store the hash on the user
            user.PasswordHash = hasher.HashPassword(user, password);

            try
            {
                using var connection = new MySqlConnection(connectionString);
                await connection.ExecuteAsync("""
                    INSERT INTO users(username, email, password_hash)
                    VALUES(@Username, @Email, @PasswordHash)
                    """,
                   user);
                return true;
            }

            //The users table won't allow the same email/username twice.
            catch (MySqlException ex) when (ex.ErrorCode == MySqlErrorCode.DuplicateKeyEntry)
            {
                return false;
            }
        }
        //log-in: returns the user variable in the case of a match.
        //wrong username and wrong password both return null, this prevents page from revealing valid usernames.
        public async Task<User?> LoginAsync(string username, string password)
        {
            //1. Look up the user by username.
            using var connection = new MySqlConnection(connectionString);
            var user = await connection.QuerySingleOrDefaultAsync<User>("""
        SELECT user_id, username, email, password_hash
        FROM users
        WHERE username = @Username
        """,
                new { Username = username });

            //2. No account with that username.
            if (user is null) return null;

            //3. Check the typed password against the stored hash.
            var result = hasher.VerifyHashedPassword(user, user.PasswordHash, password);
            if (result == PasswordVerificationResult.Failed) return null;

            // 4. Password matched.
            return user;
        }

    }
}
      
            




