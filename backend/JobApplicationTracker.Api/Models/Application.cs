using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema; // Required for ForeignKey attribute

namespace JobApplicationTracker.Api.Models;

// Enum for Application Status
public enum ApplicationStatus
{
    Applied,
    Screening,
    Interview,
    Offer,
    Rejected,
    Withdrawn
}

public class Application
{
    public int Id { get; set; } // Primary Key

    [Required]
    public int UserId { get; set; } // Foreign Key property

    [Required]
    [MaxLength(100)]
    public string CompanyName { get; set; } = string.Empty;

    [Required]
    [MaxLength(100)]
    public string JobTitle { get; set; } = string.Empty;

    [Required]
    public ApplicationStatus Status { get; set; } = ApplicationStatus.Applied; // Default status

    [Required]
    public DateTime DateApplied { get; set; }

    public string? Notes { get; set; } // Nullable text field for notes

    [MaxLength(500)] // Max length for the file path
    public string? ResumePath { get; set; } // Path to the uploaded resume file

    [MaxLength(500)]
    public string? CoverLetterPath { get; set; } // Path to the uploaded cover letter file (Added this based on plan)

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow; // Timestamp when record created
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow; // Timestamp when record last updated

    // --- Navigation Properties ---

    // Foreign Key relationship to User
    [ForeignKey("UserId")]
    public virtual User? User { get; set; } // The user who owns this application

    // One-to-many relationship with StatusHistory
    public virtual ICollection<StatusHistory> StatusHistories { get; set; } = new List<StatusHistory>();
}