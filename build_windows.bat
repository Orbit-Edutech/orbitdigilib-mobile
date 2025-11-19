@echo off
REM Script untuk build Windows app
REM Usage: build_windows.bat [release|debug]

setlocal

set BUILD_MODE=%1
if "%BUILD_MODE%"=="" set BUILD_MODE=release

echo 🚀 Building Orbit Digilib for Windows (%BUILD_MODE%)...

REM Clean previous builds
echo 🧹 Cleaning previous builds...
call flutter clean

REM Get dependencies
echo 📦 Getting dependencies...
call flutter pub get

REM Build Windows app
echo 🔨 Building Windows app...
if "%BUILD_MODE%"=="release" (
    call flutter build windows --release
) else (
    call flutter build windows --debug
)

REM Show build location
if "%BUILD_MODE%"=="release" (
    set BUILD_PATH=build\windows\runner\Release
) else (
    set BUILD_PATH=build\windows\runner\Debug
)

echo.
echo ✅ Build complete!
echo 📍 App location: %BUILD_PATH%
echo.
echo To run the app:
echo   %BUILD_PATH%\digilib.exe
echo.
echo To create installer, use Inno Setup or MSIX
echo See BUILD_DESKTOP.md for more details

endlocal
