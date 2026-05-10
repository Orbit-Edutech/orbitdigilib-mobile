@echo off
REM Script untuk build Windows app dan create installer automatically
REM Usage: build_windows.bat [release|debug] [--no-installer] [--run]

setlocal enabledelayedexpansion

REM ============================================================================
REM Configuration
REM ============================================================================

set BUILD_MODE=release
set CREATE_INSTALLER=true
set RUN_AFTER_BUILD=false
set VERBOSE=false

REM Parse command line arguments
if "%1"=="" goto setup
if /i "%1"=="release" set BUILD_MODE=release
if /i "%1"=="debug" set BUILD_MODE=debug
if /i "%1"=="--no-installer" set CREATE_INSTALLER=false
if /i "%1"=="--run" set RUN_AFTER_BUILD=true
if /i "%1"=="--verbose" set VERBOSE=true

if "%2"=="" goto setup
if /i "%2"=="release" set BUILD_MODE=release
if /i "%2"=="debug" set BUILD_MODE=debug
if /i "%2"=="--no-installer" set CREATE_INSTALLER=false
if /i "%2"=="--run" set RUN_AFTER_BUILD=true
if /i "%2"=="--verbose" set VERBOSE=true

if "%3"=="" goto setup
if /i "%3"=="release" set BUILD_MODE=release
if /i "%3"=="debug" set BUILD_MODE=debug
if /i "%3"=="--no-installer" set CREATE_INSTALLER=false
if /i "%3"=="--run" set RUN_AFTER_BUILD=true
if /i "%3"=="--verbose" set VERBOSE=true

:setup
REM Get timestamp
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c%%a%%b)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║         Orbit Digilib Windows Build ^& Installer              ║
echo ║                     Mode: %BUILD_MODE%                         ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo Build started at %mydate%_%mytime%
echo.

REM Check if running on Windows
ver >nul
if !ERRORLEVEL! NEQ 0 (
    echo ❌ Error: This script must be run on Windows
    exit /b 1
)

if "%VERBOSE%"=="true" (
    echo 📋 Options:
    echo    BUILD_MODE: %BUILD_MODE%
    echo    CREATE_INSTALLER: %CREATE_INSTALLER%
    echo    RUN_AFTER_BUILD: %RUN_AFTER_BUILD%
    echo.
)

REM ============================================================================
REM Step 1: Clean previous builds
REM ============================================================================

echo 🧹 Step 1/4: Cleaning previous builds...
if "%VERBOSE%"=="true" echo   Running: flutter clean
call flutter clean
if !ERRORLEVEL! NEQ 0 (
    echo ❌ Error: Failed to clean previous builds
    exit /b 1
)

REM Also remove build directory to force full rebuild of resource files
if exist build (
    if "%VERBOSE%"=="true" echo   Removing build directory...
    rmdir /s /q build >nul 2>&1
)

echo ✅ Clean complete
echo.

REM ============================================================================
REM Step 2: Get dependencies
REM ============================================================================

echo 📦 Step 2/4: Getting dependencies...
if "%VERBOSE%"=="true" echo   Running: flutter pub get
call flutter pub get
if !ERRORLEVEL! NEQ 0 (
    echo ❌ Error: Failed to get dependencies
    exit /b 1
)
echo ✅ Dependencies updated
echo.

REM ============================================================================
REM Step 3: Build Windows app
REM ============================================================================

echo 🔨 Step 3/4: Building Windows app (%BUILD_MODE%)...
if "%BUILD_MODE%"=="release" (
    if "%VERBOSE%"=="true" echo   Running: flutter build windows --release
    call flutter build windows --release
    set BUILD_PATH=build\windows\runner\Release
) else (
    if "%VERBOSE%"=="true" echo   Running: flutter build windows --debug
    call flutter build windows --debug
    set BUILD_PATH=build\windows\runner\Debug
)

if !ERRORLEVEL! NEQ 0 (
    echo ❌ Error: Flutter build failed
    exit /b 1
)

if not exist "!BUILD_PATH!\digilib.exe" (
    echo ❌ Error: Build output not found at !BUILD_PATH!\digilib.exe
    exit /b 1
)

echo ✅ Flutter build complete
echo   📍 Executable: !BUILD_PATH!\digilib.exe
echo.

REM ============================================================================
REM Step 4: Create installer (if enabled)
REM ============================================================================

if "%CREATE_INSTALLER%"=="false" (
    echo ⏭️  Skipping installer creation (--no-installer)
    goto summary
)

echo 📦 Step 4/4: Creating installer with Inno Setup...
echo.

REM Check if Inno Setup is installed
if "%VERBOSE%"=="true" echo   Checking for Inno Setup installation...

set INNO_PATH=
set INNO_COMPILER=

REM Try 64-bit registry first
for /f "tokens=2*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Inno Setup 6" /v InstallLocation 2^>nul') do (
    set INNO_PATH=%%b
)

REM Try 32-bit registry on 64-bit system
if "!INNO_PATH!"=="" (
    for /f "tokens=2*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Inno Setup 6" /v InstallLocation 2^>nul') do (
        set INNO_PATH=%%b
    )
)

REM Try Inno Setup 5
if "!INNO_PATH!"=="" (
    for /f "tokens=2*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Inno Setup 5" /v InstallLocation 2^>nul') do (
        set INNO_PATH=%%b
    )
)

if "!INNO_PATH!"=="" (
    echo ⚠️  Inno Setup not found
    echo.
    echo 📍 App ready at: !BUILD_PATH!\digilib.exe
    echo.
    echo To create installer:
    echo   Option 1 - Install Inno Setup:
    echo     1. Download from: https://www.innosetup.com
    echo     2. Run this script again
    echo.
    echo   Option 2 - Manual compile:
    echo     1. Open windows\installer.iss in Inno Setup
    echo     2. Click "Build" ^> "Compile"
    echo.
    echo   Option 3 - Command line (if Inno Setup is installed):
    echo     ISCC.exe windows\installer.iss
    echo.
    goto postbuild
)

set INNO_COMPILER=!INNO_PATH!ISCC.exe

if "%VERBOSE%"=="true" (
    echo   Inno Setup found at: !INNO_PATH!
    echo   Compiler: !INNO_COMPILER!
)

if not exist "!INNO_COMPILER!" (
    echo ❌ Error: Cannot find ISCC.exe
    echo   Expected path: !INNO_COMPILER!
    echo   Please reinstall Inno Setup
    exit /b 1
)

REM Create output directory
if not exist "installer_output" mkdir installer_output

REM Compile installer
if "%VERBOSE%"=="true" echo   Running: "!INNO_COMPILER!" /Q "windows\installer.iss"

"!INNO_COMPILER!" /Q "windows\installer.iss"

if !ERRORLEVEL! NEQ 0 (
    echo ❌ Error: Installer creation failed
    echo   Please check windows\installer.iss for errors
    exit /b 1
)

echo ✅ Installer created successfully
echo.

REM ============================================================================
REM Summary
REM ============================================================================

:summary
echo ✅ All done!
echo.
echo 📊 Build Summary:
echo ══════════════════════════════════════════════════════════════
echo   Build Type: %BUILD_MODE%
if "%CREATE_INSTALLER%"=="true" (
    echo   Installer: ✓ Created
) else (
    echo   Installer: ✗ Skipped
)
echo ══════════════════════════════════════════════════════════════
echo.
echo 📁 Build Artifacts:
echo   Executable: !BUILD_PATH!\digilib.exe

if "%CREATE_INSTALLER%"=="true" (
    if exist "installer_output\*.exe" (
        echo   Installer:
        for %%f in (installer_output\*.exe) do (
            echo     • %%~nxf
        )
    )
)
echo.

:postbuild
REM ============================================================================
REM Run app if requested
REM ============================================================================

if "%RUN_AFTER_BUILD%"=="true" (
    echo 🚀 Launching application...
    start "" "!BUILD_PATH!\digilib.exe"
)

REM ============================================================================
REM Next steps
REM ============================================================================

echo 🎯 Next Steps:
echo ──────────────────────────────────────────────────────────────
if "%CREATE_INSTALLER%"=="true" (
    echo   1. Test installer:
    echo      start installer_output\OrbitDigilibSetup_*.exe
    echo.
    echo   2. Distribute installer to users
) else (
    echo   1. Run executable:
    echo      start !BUILD_PATH!\digilib.exe
    echo.
    echo   2. To create installer, run without --no-installer flag:
    echo      build_windows.bat %BUILD_MODE%
)
echo ──────────────────────────────────────────────────────────────
echo.

REM ============================================================================
REM Help/Usage
REM ============================================================================

echo 📖 Usage Examples:
echo ──────────────────────────────────────────────────────────────
echo   Release with installer:     build_windows.bat release
echo   Debug build, no installer:  build_windows.bat debug --no-installer
echo   Release and run app:        build_windows.bat release --run
echo   Debug with verbose output:  build_windows.bat debug --verbose
echo ──────────────────────────────────────────────────────────────
echo.

endlocal
exit /b 0
