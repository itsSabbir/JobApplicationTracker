# Job Application Tracker

## About The Project

This project is a web application designed to help users efficiently track and manage their job applications throughout the hiring process. It provides a centralized platform to store application details, manage documents, monitor status changes, and receive reminders.

Built with ASP.NET Core 8 for the backend API and potentially Blazor Server/WASM or a JavaScript framework (React/Angular) for the frontend, this application demonstrates full-stack development capabilities, including database design, authentication, file handling, background services, and cloud deployment.

## Core Features (Project Scope - v1.0)

The initial version of the Job Application Tracker will include the following core features:

*   **User Management:**
    *   User Registration (Secure account creation)
    *   User Login (JWT-based authentication)
    *   Forgot Password (Email-based password reset functionality)
*   **Job Application Management:**
    *   Create new job application entries (Company, Title, Date Applied, Notes)
    *   Edit existing application details
    *   Delete applications
*   **Document Uploads:**
    *   Upload resumes associated with specific applications
    *   Upload cover letters associated with specific applications
    *   (Validation for allowed file types like PDF, DOCX)
*   **Application Pipeline Tracking:**
    *   Assign and update application status (e.g., Applied, Screening, Interview, Offer, Rejected)
    *   View history of status changes for an application
*   **Search, Sort, and Filter:**
    *   Search applications by Company Name or Job Title
    *   Sort applications by Date Applied, Company Name, or Status
    *   Filter applications by Status
*   **Email Reminders:**
    *   Automated email notifications for upcoming scheduled interviews (based on application data).
*   **User Dashboard:**
    *   Display key statistics:
        *   Total applications submitted
        *   Number of active interviews
        *   Number of offers received
        *   Calculated success/conversion rates (e.g., Interview Rate, Offer Rate)

## Technology Stack (Planned)

*   **Backend:** ASP.NET Core 8 Web API
*   **Database:** SQL Server / PostgreSQL
*   **ORM:** Entity Framework Core 8
*   **Authentication:** ASP.NET Core Identity, JWT
*   **Logging:** Serilog
*   **Email:** SendGrid (or similar)
*   **Frontend:** Blazor Server (or React/Angular/Blazor WASM)
*   **Testing:** xUnit, Moq
*   **Deployment:** Docker, Azure (App Service, SQL Database, Static Web Apps)
*   **CI/CD:** GitHub Actions (Optional)

## Project Goals

*   To build a functional, real-world application demonstrating modern .NET development practices.
*   To create a valuable tool for personal job searching.
*   To serve as a comprehensive portfolio piece showcasing skills across the full development lifecycle.

---

*(This README will be updated throughout the project with setup instructions, architecture details, API documentation links, and deployment information.)*
