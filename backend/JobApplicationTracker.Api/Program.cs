using Serilog; // <-- Add this

// Configure Serilog logger FIRST for bootstrap logging
Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
        .AddJsonFile($"appsettings.{Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Production"}.json", optional: true)
        .Build())
    .Enrich.FromLogContext()
    .WriteTo.Console()
    .CreateBootstrapLogger(); // Use bootstrap logger

try
{
    Log.Information("Starting JobApplicationTracker.Api web host"); // Log startup

    var builder = WebApplication.CreateBuilder(args);

    // --- Configure Serilog as the primary logging provider ---
    builder.Host.UseSerilog((context, services, configuration) => configuration
        .ReadFrom.Configuration(context.Configuration) // Read final config from builder.Configuration
        .ReadFrom.Services(services) // Allow DI access for sinks if needed
        .Enrich.FromLogContext());
    // --- End Serilog configuration ---

    // Add services to the container.
    builder.Services.AddControllers();
    // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
    builder.Services.AddEndpointsApiExplorer();
    builder.Services.AddSwaggerGen(); // Swagger is enabled by default

    var app = builder.Build();

    // Configure the HTTP request pipeline.

    // --- Use Serilog Request Logging (Optional but Recommended) ---
    // Adds middleware for richer HTTP request logging. Place it early.
    app.UseSerilogRequestLogging();
    // --- End Serilog Request Logging ---

    if (app.Environment.IsDevelopment())
    {
        app.UseSwagger();
        app.UseSwaggerUI(); // Serves Swagger UI at /swagger
    }

    app.UseHttpsRedirection();

    app.UseAuthorization(); // We will configure this properly later

    app.MapControllers(); // Maps attribute-routed controllers like WeatherForecastController

    app.Run();

}
catch (Exception ex)
{
    Log.Fatal(ex, "Host terminated unexpectedly"); // Log fatal errors during startup
    return 1; // Indicate abnormal termination
}
finally
{
    Log.CloseAndFlush(); // Ensure all logs are written before exiting
}

return 0; // Indicate successful termination (if Run completes normally)