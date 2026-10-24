namespace Perch.Models
{

    //One row of the sightings table. Ex: I saw N of this bird on this day.
    //Dapper fills these by name, the same way it does for the Bird class.
    public class Sighting
    {
        //columns in the sightings table
        public int SightingId { get; set; }
        public int UserId { get; set; }
        public int BirdId { get; set; }
        public int BirdCount { get; set; }
        public DateTime SeenOn { get; set; }
        public string? Notes { get; set; }

        //Joined from the birds table so the card shows the names.
        public string CommonName { get; set; } = "";
        public string LatinName { get; set; } = "";
    }
}
