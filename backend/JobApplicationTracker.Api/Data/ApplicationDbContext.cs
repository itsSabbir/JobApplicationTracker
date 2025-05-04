using Microsoft.EntityFrameworkCore;
using JobApplicationTracker.Api.Models; // Import your models namespace

namespace JobApplicationTracker.Api.Data;

public class ApplicationDbContext : DbContext
{
    // Constructor needed for dependency injection
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }

    // DbSet properties represent tables in the database
    public DbSet<User> Users { get; set; }
    public DbSet<Application> Applications { get; set; }
    public DbSet<StatusHistory> StatusHistories { get; set; }

    // Optional: Configure model details here if not using annotations or need more complex setup
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Example: Configure relationships explicitly if needed (often inferred by convention)
        modelBuilder.Entity<Application>()
            .HasOne(a => a.User) // Application has one User
            .WithMany(u => u.Applications) // User has many Applications
            .HasForeignKey(a => a.UserId) // Foreign key is UserId
            .OnDelete(DeleteBehavior.Cascade); // If User is deleted, delete their Applications (adjust as needed)

        modelBuilder.Entity<StatusHistory>()
            .HasOne(sh => sh.Application) // StatusHistory has one Application
            .WithMany(a => a.StatusHistories) // Application has many StatusHistories
            .HasForeignKey(sh => sh.ApplicationId) // Foreign key is ApplicationId
            .OnDelete(DeleteBehavior.Cascade); // If Application is deleted, delete its history

        // Example: Add an index for faster lookups (optional but good practice)
        modelBuilder.Entity<User>()
            .HasIndex(u => u.Email)
            .IsUnique(); // Ensure email addresses are unique

        modelBuilder.Entity<Application>()
            .HasIndex(a => new { a.UserId, a.DateApplied }); // Example composite index

        // Seed data (optional - for initial data)
        // modelBuilder.Entity<YourModel>().HasData(new YourModel { ... });
    }
}