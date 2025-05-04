@echo off
setlocal enabledelayedexpansion

:: --- Configuration ---
:: Get the directory where the script itself is located
set SCRIPT_DIR=%~dp0
:: Remove trailing backslash if present
if %SCRIPT_DIR:~-1%==\ set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%

set PROJECT_ROOT=%SCRIPT_DIR%
set BACKEND_DIR=%PROJECT_ROOT%\backend
set PROJECT_NAME=JobApplicationTracker.Api
set PROJECT_PATH=%BACKEND_DIR%\%PROJECT_NAME%
set SOLUTION_NAME=JobApplicationTracker
set REQUIRED_SDK_MAJOR_VERSION=8
:: --- End Configuration ---

:: Set the title of the command window
title Job Application Tracker Backend Setup

:START
cls
echo ============================================================
echo  Job Application Tracker - Backend Setup Script
echo ============================================================
echo.
echo Project Root: %PROJECT_ROOT%
echo Backend Dir:  %BACKEND_DIR%
echo Project Name: %PROJECT_NAME%
echo Project Path: %PROJECT_PATH%
echo Solution Name:%SOLUTION_NAME%
echo.
echo Press any key to begin the checks and setup...
echo (Script will wait here)
pause
echo (Resuming script...)
cls

:: ============================================================
:: STEP 1: Check for .NET SDK
:: ============================================================
echo === STEP 1: Checking for .NET SDK v%REQUIRED_SDK_MAJOR_VERSION%.x ===
dotnet --list-sdks | findstr /B /C:"%REQUIRED_SDK_MAJOR_VERSION%." > nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] .NET SDK Version %REQUIRED_SDK_MAJOR_VERSION%.x was NOT found.
    echo.
    echo Please perform the following steps MANUALLY:
    echo   1. Download and install the .NET %REQUIRED_SDK_MAJOR_VERSION% SDK (x64) from:
    echo      https://dotnet.microsoft.com/download/dotnet/%REQUIRED_SDK_MAJOR_VERSION%.0
    echo   2. IMPORTANT: RESTART YOUR COMPUTER after installation (Recommended).
    echo      (Alternatively, try closing ALL terminals/VS Code, or log off/on first)
    echo   3. Rerun this script (setup_backend.bat) after installing/restarting.
    echo.
    goto :EXIT_SCRIPT
) else (
    echo [OK] .NET SDK v%REQUIRED_SDK_MAJOR_VERSION%.x found.
    dotnet --list-sdks | findstr /B /C:"%REQUIRED_SDK_MAJOR_VERSION%."
)
echo.
echo === Pausing after SDK check ===
pause

:: ============================================================
:: STEP 2: Ensure Backend Directory Exists
:: ============================================================
cls
echo === STEP 2: Checking/Creating Backend Directory ===
if not exist "%BACKEND_DIR%" (
    echo Creating directory: %BACKEND_DIR%
    mkdir "%BACKEND_DIR%"
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Failed to create directory: %BACKEND_DIR%
        goto :EXIT_SCRIPT
    ) else (
        echo [OK] Directory created.
    )
) else (
    echo [OK] Directory already exists: %BACKEND_DIR%
)
echo.
echo === Pausing after Directory check ===
pause

:: ============================================================
:: STEP 3: Create ASP.NET Core Web API Project
:: ============================================================
cls
echo === STEP 3: Checking/Creating API Project ===
if not exist "%PROJECT_PATH%\%PROJECT_NAME%.csproj" (
    echo Project does not exist. Creating %PROJECT_NAME%...
    echo Changing directory to: %BACKEND_DIR%
    pushd "%BACKEND_DIR%"
    if !ERRORLEVEL! neq 0 ( echo [ERROR] Failed to change directory to %BACKEND_DIR%. & goto :EXIT_SCRIPT )

    echo Running: dotnet new webapi -n %PROJECT_NAME% --use-controllers -f net%REQUIRED_SDK_MAJOR_VERSION%.0 -o %PROJECT_NAME%
    dotnet new webapi -n %PROJECT_NAME% --use-controllers -f net%REQUIRED_SDK_MAJOR_VERSION%.0 -o %PROJECT_NAME%
    if !ERRORLEVEL! neq 0 (
        echo [ERROR] Failed to create the Web API project '%PROJECT_NAME%'. Check errors above.
        popd
        goto :EXIT_SCRIPT
    ) else (
        echo [OK] Web API project created successfully in %PROJECT_PATH%
    )
    popd
) else (
    echo [OK] Project already exists: %PROJECT_PATH%
)
echo.
echo === Pausing after Project creation check/attempt ===
pause

:: ============================================================
:: STEP 4: Create Solution File
:: ============================================================
cls
echo === STEP 4: Checking/Creating Solution File ===
if not exist "%BACKEND_DIR%\%SOLUTION_NAME%.sln" (
    echo Solution file does not exist. Creating %SOLUTION_NAME%.sln...
    echo Changing directory to: %BACKEND_DIR%
    pushd "%BACKEND_DIR%"
     if !ERRORLEVEL! neq 0 ( echo [ERROR] Failed to change directory to %BACKEND_DIR%. & goto :EXIT_SCRIPT )

    echo Running: dotnet new sln -n %SOLUTION_NAME%
    dotnet new sln -n %SOLUTION_NAME%
    if !ERRORLEVEL! neq 0 (
        echo [ERROR] Failed to create the solution file '%SOLUTION_NAME%.sln'.
        popd
        goto :EXIT_SCRIPT
    ) else (
        echo [OK] Solution file created successfully.
    )
    popd
) else (
    echo [OK] Solution file already exists: %BACKEND_DIR%\%SOLUTION_NAME%.sln
)
echo.
echo === Pausing after Solution file check/attempt ===
pause

:: ============================================================
:: STEP 5: Add Project to Solution
:: ============================================================
cls
echo === STEP 5: Adding Project to Solution ===
REM Check if both solution and project exist before trying to add
if exist "%BACKEND_DIR%\%SOLUTION_NAME%.sln" if exist "%PROJECT_PATH%\%PROJECT_NAME%.csproj" (
    echo Adding project %PROJECT_NAME% to solution %SOLUTION_NAME%.sln...
    echo Changing directory to: %BACKEND_DIR%
    pushd "%BACKEND_DIR%"
    if !ERRORLEVEL! neq 0 ( echo [ERROR] Failed to change directory to %BACKEND_DIR%. & goto :EXIT_SCRIPT )

    echo Running: dotnet sln %SOLUTION_NAME%.sln add "%PROJECT_NAME%\%PROJECT_NAME%.csproj"
    dotnet sln %SOLUTION_NAME%.sln add "%PROJECT_NAME%\%PROJECT_NAME%.csproj"
    REM This command might show a warning if already added, which is fine. Check for actual errors.
    if !ERRORLEVEL! gtr 1 (
        echo [WARNING/ERROR] Failed to add project to solution (Code: !ERRORLEVEL!). Might already be added or another issue occurred.
        REM Not exiting here as it might just be a warning
    ) else (
        echo [OK] Project add command executed (check output for details - warnings are okay).
    )
    popd
) else (
    echo [SKIP] Cannot add project to solution because solution file or project is missing.
)
echo.
echo === Pausing after adding project to solution ===
pause

:: ============================================================
:: STEP 6: Install Serilog NuGet Packages
:: ============================================================
cls
echo === STEP 6: Installing Serilog NuGet Packages ===
if exist "%PROJECT_PATH%\%PROJECT_NAME%.csproj" (
    echo Changing directory to %PROJECT_PATH%
    pushd "%PROJECT_PATH%"
    if !ERRORLEVEL! neq 0 ( echo [ERROR] Failed to change directory to %PROJECT_PATH%. & goto :EXIT_SCRIPT )

    echo Installing Serilog.AspNetCore...
    dotnet add package Serilog.AspNetCore
    if !ERRORLEVEL! neq 0 ( echo [ERROR] Failed to install Serilog.AspNetCore. & popd & goto :EXIT_SCRIPT )

    echo Installing Serilog.Sinks.Console...
    dotnet add package Serilog.Sinks.Console
    if !ERRORLEVEL! neq 0 ( echo [ERROR] Failed to install Serilog.Sinks.Console. & popd & goto :EXIT_SCRIPT )

    echo Installing Serilog.Sinks.File...
    dotnet add package Serilog.Sinks.File
    if !ERRORLEVEL! neq 0 ( echo [ERROR] Failed to install Serilog.Sinks.File. & popd & goto :EXIT_SCRIPT )

    echo [OK] Serilog packages added/updated successfully.
    popd
) else (
    echo [SKIP] Project path %PROJECT_PATH% not found. Cannot install NuGet packages.
)
echo.
echo === Pausing after NuGet package installation ===
pause

:: ============================================================
:: STEP 7: Manual Configuration Reminder
:: ============================================================
cls
echo === STEP 7: IMPORTANT - Manual Steps Required ===
echo.
echo The basic project structure and packages are set up.
echo You NOW need to MANUALLY configure Serilog:
echo   1. Edit the '%PROJECT_PATH%\Program.cs' file.
echo      - Add 'using Serilog;'
echo      - Add the Serilog configuration code before 'builder.Build()'.
echo      - Add 'builder.Host.UseSerilog(...);'
echo      - Add 'app.UseSerilogRequestLogging();'
echo      - Wrap the main execution in a try/catch/finally block for logging.
echo      (Refer back to the detailed instructions from Step 3.5 if needed)
echo.
echo   2. Edit the '%PROJECT_PATH%\appsettings.json' file.
echo      - Add the "Serilog" configuration section.
echo      (Refer back to the detailed instructions from Step 3.6 if needed)
echo.
echo After these manual edits, you can run the project using 'dotnet run'
echo from the '%PROJECT_PATH%' directory.
echo.

:EXIT_SCRIPT
echo ============================================================
echo Script finished. Press any key to close this window.
echo ============================================================
echo.
endlocal
pause
exit /b