namespace Perch.Models
{
    //One row of the birds table. Dapper fills these by name:
    //Converts MySQL's snake case (bird_id) to Pascal case used in Visual Studio (BirdId).
    //(turned on in Program.cs with MatchNamesWithUnderscores).
    public class Bird
    {
        //Columns in the birds table
        public int BirdId { get; set; }
        public string CommonName { get; set; } = "";
        public string LatinName { get; set; } = "";
        public string? LatinPronunciation { get; set; }
        public int FamilyId { get; set; }
        public decimal SizeMinIn { get; set; }
        public decimal SizeMaxIn { get; set; }
        public string? Description { get; set; }

        //Joined in from other tables
        public string FamilyName { get; set; } = "";
        public string? PhotoFile { get; set; }   //featured image from the images table

        //Filled only by BirdService.GetByIdAsync (Bird Profile)
        public List<BirdImage> Images { get; set; } = new();
        public List<string> Colors { get; set; } = new();
        public List<string> Habitats { get; set; } = new();
        //Filled only by BirdService.GetLifeListAsync (Life List)
        //how many total sightings the user has logged for this bird
        public int TotalCount { get; set; }

        public string PhotoUrl => PhotoFile is null
            ? "images/icons/perchLogo.svg"
            : $"images/birdPhotos/{PhotoFile}";

        //Adds small thumbnail to bird lists.
        //Every thumbnail is a .jpg, even if original is .png or .webp. 
        public string ThumbUrl => PhotoFile is null
            ? "images/icons/perchLogo.svg"
            : 
            $"images/birdThumbs/{Path.ChangeExtension(PhotoFile, ".jpg")}";

        //turns the two size numbers into readable text for the profile page
        public string SizeText
        {
            get
            {
                if (SizeMinIn == SizeMaxIn)
                {
                    return $"{SizeMinIn:0.#} in";
                }

                return $"{SizeMinIn:0.#}–{SizeMaxIn:0.#} in";
            }
        }
    }
}
