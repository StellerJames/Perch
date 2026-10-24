namespace Perch.Models
{
    //One row of the users table. PasswordHash holds the hashed password, never the plain one.
    public class User
    {
        public int UserId { get; set; }
        public string Username { get; set; } = "";
        public string Email { get; set; } = "";
        public string PasswordHash { get; set; } = "";
    }
}
