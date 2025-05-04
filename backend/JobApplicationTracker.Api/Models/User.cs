using System.ComponentModel.DataAnnotations; // Required for annotations

namespace JobApplicationTracker.Api.Models;

public class User
{
    public int Id { get; set; } // Primary Key (by convention)

    [Required] // Makes this field mandatory in the database
    [EmailAddress] // Adds email format validation
    [MaxLength(256)] // Sets a reasonable max length
    public string Email { get; set; } = string.Empty;

    [Required]
    public string PasswordHash { get; set; } = string.Empty; // Store hashed password, not plain text!

    [MaxLength(100)]
    public string? FullName { get; set; } // Nullable string, max length 100

    // Navigation Property: A user can have many applications
    public virtual ICollection<Application> Applications { get; set; } = new List<Application>();
}