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

## Development Environment Setup

To set up your local development environment for this project, you will need the following tools installed:

1.  **.NET 8 SDK:**
    *   **Required:** The core Software Development Kit for building .NET applications.
    *   **Download:** [https://dotnet.microsoft.com/download/dotnet/8.0](https://dotnet.microsoft.com/download/dotnet/8.0)
    *   **Verify Installation:** Open a terminal or command prompt and run `dotnet --version`. You should see a version starting with `8.x.x`.

2.  **Visual Studio 2022 (or later):**
    *   **Recommended IDE:** Provides a rich development experience for .NET. The Community Edition is free.
    *   **Download:** [https://visualstudio.microsoft.com/vs/](https://visualstudio.microsoft.com/vs/)
    *   **Required Workloads:** During installation, ensure you select:
        *   `ASP.NET and web development`
    *   **Optional but Recommended Components:**
        *   `Data storage and processing` (Includes SQL Server tools)
        *   `Container development tools` (For Docker integration)

3.  **Entity Framework Core Tools:**
    *   **Required:** For managing database migrations (code-first approach).
    *   **Installation:** Open a terminal or command prompt and run:
        ```bash
        dotnet tool install --global dotnet-ef
        ```
    *   **Verify Installation:** Run `dotnet ef --version`.

4.  **Database Server:**
    *   **Choose ONE:**
        *   **SQL Server Developer Edition:** A full-featured free edition for development and testing.
            *   **Download:** [https://www.microsoft.com/en-us/sql-server/sql-server-downloads](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
            *   **Management Tool:** SQL Server Management Studio (SSMS) - [Download SSMS](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)
        *   **PostgreSQL:** A powerful open-source object-relational database system.
            *   **Download:** [https://www.postgresql.org/download/](https://www.postgresql.org/download/)
            *   **Management Tool:** pgAdmin - [Download pgAdmin](https://www.pgadmin.org/download/) or DBeaver.
    *   **Note:** The project will initially be configured for one, but EF Core allows switching relatively easily. We will likely start with SQL Server unless you prefer PostgreSQL.

5.  **API Testing Tool:**
    *   **Required:** For testing the backend API endpoints.
    *   **Recommended:** Postman
        *   **Download:** [https://www.postman.com/downloads/](https://www.postman.com/downloads/)
    *   **Alternatives:** Insomnia, Visual Studio Code REST Client extension.

6.  **Git:**
    *   **Required:** For version control.
    *   **Download:** [https://git-scm.com/downloads](https://git-scm.com/downloads)

7.  **(Optional) Docker Desktop:**
    *   **Recommended for later phases:** Useful for containerizing the application and database for consistent environments and deployment.
    *   **Download:** [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)

---

Once you have these tools installed, you should be ready to clone the repository (if applicable) and start building the backend.

## Project Goals

*   To build a functional, real-world application demonstrating modern .NET development practices.
*   To create a valuable tool for personal job searching.
*   To serve as a comprehensive portfolio piece showcasing skills across the full development lifecycle.

---

*(This README will be updated throughout the project with setup instructions, architecture details, API documentation links, and deployment information.)*