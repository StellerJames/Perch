namespace Perch.Models
{
    //One row of the images table, plus its license from the licenses table.
    public class BirdImage
    {
        public int ImageId { get; set; }
        public int BirdId { get; set; }
        public string? PageUrl { get; set; }
        public string? ImageFile { get; set; }
        public string Author { get; set; } = "";
        public string Source { get; set; } = "";
        public bool IsFeatured { get; set; }

        public string LicenseName { get; set; } = "";
        public string? LicenseUrl { get; set; }
        public bool RequiresAttribution { get; set; }

        public string Url => $"images/birdPhotos/{ImageFile}";
    }
}
