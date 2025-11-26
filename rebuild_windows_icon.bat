@echo off
REM Quick rebuild script specifically for icon changes
REM This ensures resource files are properly recompiled

setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║     Windows Icon Rebuild - Force Recompile Resources          ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

echo 📋 Checking icon file...
if not exist "windows\runner\resources\app_icon.ico" (
    echo ❌ Error: Icon file not found at windows\runner\resources\app_icon.ico
    exit /b 1
)
echo ✅ Icon found: windows\runner\resources\app_icon.ico
echo.

echo 🧹 Cleaning build artifacts...
call flutter clean
if exist build rmdir /s /q build >nul 2>&1
if "%1"=="" (
    if exist windows\runner\Release rmdir /s /q windows\runner\Release >nul 2>&1
    if exist windows\runner\Debug rmdir /s /q windows\runner\Debug >nul 2>&1
)
echo ✅ Clean complete
echo.

echo 📦 Getting dependencies...
call flutter pub get
if !ERRORLEVEL! NEQ 0 (
    echo ❌ Error: Failed to get dependencies
    exit /b 1
)
echo ✅ Dependencies ready
echo.

set BUILD_MODE=release
if "%1"=="debug" set BUILD_MODE=debug

echo 🔨 Building with new icon (%BUILD_MODE%)...
if "%BUILD_MODE%"=="release" (
    call flutter build windows --release
) else (
    call flutter build windows --debug
)

if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ❌ Error: Build failed
    exit /b 1
)

echo.
echo ✅ Build complete with updated icon!
echo.
echo 📝 Next step: Create installer with:
echo    build_windows.bat %BUILD_MODE%
echo.

endlocal
exit /b 0
