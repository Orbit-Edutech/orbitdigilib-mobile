# Windows Build & Installer Script Guide

## Overview

Script `build_windows.bat` mengotomatisasi proses build Flutter Windows dan membuat installer executable secara langsung.

## Prerequisites

### Required
1. **Flutter SDK** - Harus sudah ter-install
   ```bash
   flutter --version
   ```

2. **Inno Setup 6** - Untuk membuat installer Windows
   - Download: https://www.innosetup.com/
   - Installer akan auto-detect dari registry

### Optional
- Visual Studio Build Tools (sudah included dengan Flutter)
- Chocolatey (untuk easy installation)

## Installation

### Option 1: Manual Download
1. Download Inno Setup 6 dari: https://www.innosetup.com/
2. Jalankan installer dan complete installation
3. Restart terminal

### Option 2: Chocolatey (Admin required)
```batch
choco install innosetup
```

### Option 3: Verify Installation
```batch
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Inno Setup 6"
```

## Storage & Database

Aplikasi menggunakan SQLite untuk storage lokal yang sekarang **fully cross-platform** (Android, iOS, Windows, macOS, Linux).

### Database Location

**Windows**:
```
C:\Users\{username}\AppData\Local\{app_data}\digilib.db
```

Untuk Orbit Digilib: `C:\Users\{username}\AppData\Local\<app_user_data>\digilib.db`

### Stored Data

- **Buku (Books)**: Offline reading history, last page, status
- **Halaman Bintang (Starred Pages)**: Bookmarked pages dalam buku
- **Notifikasi (Notifications)**: Local notification cache

### Important Notes

- Database automatically created on first app run
- User data persists after app closes
- No special installation required for database
- User can safely delete app without uninstall script affecting database location

## Usage

### Basic Commands

#### 1. Release Build with Installer (DEFAULT)
```batch
build_windows.bat release
```
- Clean project
- Get dependencies
- Build Windows release
- Compile Inno Setup installer
- Output: `installer_output\OrbitDigilibSetup_1.2.1.exe`

#### 2. Debug Build without Installer
```batch
build_windows.bat debug --no-installer
```
- Build debug version
- Skip installer creation
- Output: `build\windows\runner\Debug\digilib.exe`

#### 3. Release Build and Run App
```batch
build_windows.bat release --run
```
- Build release
- Create installer
- Launch app automatically

#### 4. Debug with Verbose Output
```batch
build_windows.bat debug --verbose
```
- Show detailed execution steps
- Display all configuration options
- Useful for troubleshooting

## Build Process

Script menjalankan 4 langkah utama:

```
Step 1/4: flutter clean
    └─ Remove previous build artifacts

Step 2/4: flutter pub get
    └─ Download and update dependencies

Step 3/4: flutter build windows --release
    └─ Compile Flutter to Windows executable
    
Step 4/4: ISCC.exe windows\installer.iss
    └─ Compile Inno Setup script to EXE installer
```

## Output Files

### Release Build
```
build/windows/runner/Release/
├── digilib.exe              (main executable)
├── *.dll                    (dependencies)
└── data/                    (assets, resources)

installer_output/
└── OrbitDigilibSetup_1.2.1.exe   (distributable installer)
```

### Debug Build
```
build/windows/runner/Debug/
├── digilib.exe              (main executable)
├── *.dll                    (dependencies)
└── data/                    (assets, resources)
```

## Installer Configuration

File: `windows/installer.iss`

Konfigurasi:
- **App Name**: Orbit Digilib
- **Version**: 1.2.1 (auto dari variable)
- **Publisher**: Orbit360
- **Install Path**: `C:\Program Files\Orbit Digilib`
- **License**: LICENSE file
- **Icon**: `runner/resources/app_icon.ico`

Customize dengan edit `windows/installer.iss`:
```inno
#define MyAppName "Orbit Digilib"
#define MyAppVersion "1.2.1"
#define MyAppPublisher "Orbit360"
```

## Troubleshooting

### Error: "Inno Setup not found"

**Solution 1**: Install Inno Setup
```
https://www.innosetup.com/
→ Download & Install
→ Restart terminal
```

**Solution 2**: Manual compile
```
1. Open: windows\installer.iss
2. Click: Build → Compile
3. Output: installer_output\OrbitDigilibSetup_*.exe
```

**Solution 3**: Check registry
```batch
REM 64-bit
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Inno Setup 6"

REM 32-bit on 64-bit system
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Inno Setup 6"
```

### Error: "Flutter build failed"

**Solutions**:
1. Delete `build` folder: `flutter clean`
2. Update dependencies: `flutter pub get`
3. Check Flutter status: `flutter doctor`
4. Run with verbose: `build_windows.bat release --verbose`

### Error: "Cannot find ISCC.exe"

**Solutions**:
1. Uninstall & reinstall Inno Setup
2. Add to PATH manually:
   ```batch
   setx PATH "%PATH%;C:\Program Files (x86)\Inno Setup 6"
   ```
3. Verify with: `where ISCC.exe`

### Build output missing

**Check**:
1. `build\windows\runner\Release\digilib.exe` exists?
2. Run `flutter doctor` check
3. Check disk space (at least 2GB free)
4. Try `flutter clean` and rebuild

## Advanced Usage

### Combine multiple flags
```batch
REM Debug build with detailed output, skip installer, run app
build_windows.bat debug --no-installer --run --verbose
```

### Automated CI/CD
```batch
REM In CI/CD pipeline
build_windows.bat release
REM Check exit code
if %ERRORLEVEL% EQU 0 (
    echo Build successful
    REM Upload installer_output\*.exe
)
```

### Build specific version
Edit `windows/installer.iss`:
```inno
#define MyAppVersion "2.0.0"
```
Then run:
```batch
build_windows.bat release
```

## Distribution

### End User Installation

1. Download: `OrbitDigilibSetup_1.2.1.exe`
2. Double-click or run
3. Follow installer wizard
4. Choose install location
5. Create desktop shortcut (optional)
6. App starts after installation

### Distribution Methods

1. **Direct Download**
   - Host on website
   - User downloads and runs

2. **Cloud Storage**
   - OneDrive, Google Drive, Dropbox
   - Share download link

3. **Package Managers**
   - Chocolatey package
   - Windows Package Manager

4. **Internal Distribution**
   - Network drive
   - Company app store

## Environment Variables

None required, but can customize:

```batch
REM In build_windows.bat
set FLUTTER_BUILD_MODE=release
set INNO_SETUP_PATH=C:\Program Files (x86)\Inno Setup 6
```

## Performance Tips

1. **First build** (~5-10 minutes)
   - More time due to dependency download

2. **Subsequent builds** (~2-5 minutes)
   - Faster with cached dependencies

3. **Speed up**:
   - Use `--no-installer` flag during development
   - Build incrementally: `flutter build windows`
   - Use faster disk (SSD recommended)

## Version Management

### Update Version Number

1. Edit `windows/installer.iss`:
   ```inno
   #define MyAppVersion "1.3.0"
   ```

2. Edit `pubspec.yaml`:
   ```yaml
   version: 1.3.0+1
   ```

3. Rebuild:
   ```batch
   build_windows.bat release
   ```

## Exit Codes

- `0` - Success
- `1` - Error (check output for details)

## Support & References

- Flutter Windows Docs: https://flutter.dev/docs/deployment/windows
- Inno Setup Docs: https://jrsoftware.org/isinfo.php
- Issue Tracking: Check project repository

## Example Workflow

```batch
REM Development iteration
build_windows.bat debug --no-installer --run

REM Pre-release testing
build_windows.bat release --run

REM Final build for distribution
build_windows.bat release

REM Install & test
start installer_output\OrbitDigilibSetup_1.2.1.exe
```

---

**Last Updated**: 2024
**Version**: 1.0
