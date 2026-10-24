using Perch.Models;

namespace Perch.Services
{

    //Remembers who is logged in for this browser tab. 
    //Registered as Scoped in Program.cs.
    public class CurrentUser
    {
        public int? UserId { get; private set; }
        public string Username { get; private set; } = "";
        public bool IsLoggedIn => UserId != null;
    
      public void LogIn(User user)
        {
            UserId = user.UserId;
            Username = user.Username;
        }

        public void LogOut()
        {
            UserId = null;
            Username = "";
        }
    } 
}
