using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace JobApplicationTracker.Api.Models;

public class StatusHistory
{
    public int Id { get; set; } // Primary Key

    [Required]
    public int ApplicationId { get; set; } // Foreign Key property

    [Required]
    public ApplicationStatus Status { get; set; } // The status at this point in time

    [Required]
    public DateTime DateChanged { get; set; } = DateTime.UtcNow; // When this status was set

    // --- Navigation Property ---

    // Foreign Key relationship to Application
    [ForeignKey("ApplicationId")]
    public virtual Application? Application { get; set; } // The application this history belongs to
}