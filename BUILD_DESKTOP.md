# Panduan Build untuk Desktop (Windows & macOS)

## Prasyarat

### Untuk macOS
- macOS dengan Xcode terinstal
- CocoaPods (`sudo gem install cocoapods`)
- Flutter SDK

### Untuk Windows
- Windows 10 atau lebih baru
- Visual Studio 2022 dengan "Desktop development with C++" workload
- Flutter SDK

## Build untuk macOS

### 1. Build Debug (untuk testing)
```bash
flutter build macos --debug
```

### 2. Build Release (untuk distribusi)
```bash
flutter build macos --release
```

### 3. Lokasi hasil build
Aplikasi akan tersedia di: `build/macos/Build/Products/Release/digilib.app`

### 4. Membuat DMG untuk distribusi (opsional)
Anda bisa menggunakan tool seperti `create-dmg`:
```bash
npm install --global create-dmg
create-dmg 'build/macos/Build/Products/Release/digilib.app'
```

### 5. Code Signing (untuk distribusi publik)
Untuk distribusi di luar App Store, Anda perlu:
1. Developer ID Certificate dari Apple
2. Notarization
```bash
# Sign
codesign --deep --force --verify --verbose --sign "Developer ID Application: Your Name" "digilib.app"

# Notarize
xcrun notarytool submit digilib.zip --apple-id "your@email.com" --team-id "YOUR_TEAM_ID" --password "app-specific-password"
```

## Build untuk Windows

**CATATAN**: Build Windows harus dilakukan di mesin Windows.

### 1. Setup
Pastikan Flutter config untuk Windows sudah enabled:
```bash
flutter config --enable-windows-desktop
```

### 2. Build Debug (untuk testing)
```bash
flutter build windows --debug
```

### 3. Build Release (untuk distribusi)
```bash
flutter build windows --release
```

### 4. Lokasi hasil build
Aplikasi akan tersedia di: `build\windows\runner\Release\`

Folder yang perlu didistribusikan:
```
build\windows\runner\Release\
├── digilib.exe
├── flutter_windows.dll
├── data\
└── [DLL dependencies lainnya]
```

### 5. Membuat Installer (opsional)

#### Menggunakan Inno Setup
1. Download dan install [Inno Setup](https://jrsoftware.org/isdl.php)
2. Buat file `installer.iss` (contoh ada di bawah)
3. Compile dengan Inno Setup Compiler

Contoh `windows/installer.iss`:
```innosetup
[Setup]
AppName=Orbit Digilib
AppVersion=1.2.1
DefaultDirName={autopf}\Orbit Digilib
DefaultGroupName=Orbit Digilib
OutputDir=installer_output
OutputBaseFilename=OrbitDigilibSetup
Compression=lzma2
SolidCompression=yes

[Files]
Source: "..\build\windows\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs

[Icons]
Name: "{group}\Orbit Digilib"; Filename: "{app}\digilib.exe"
Name: "{autodesktop}\Orbit Digilib"; Filename: "{app}\digilib.exe"
```

#### Menggunakan MSIX (untuk Microsoft Store)
```bash
flutter pub add msix
flutter pub get
flutter build windows --release
flutter pub run msix:create
```

## Troubleshooting

### macOS: Pod install gagal
```bash
cd macos
pod repo update
pod install
cd ..
```

### Windows: Missing Visual Studio tools
Pastikan Anda sudah install "Desktop development with C++" workload di Visual Studio Installer.

### Permission errors
Beberapa plugin mungkin memerlukan konfigurasi tambahan untuk desktop. Check dokumentasi plugin individual.

## Plugin Support

Plugin yang digunakan dalam project ini umumnya sudah support desktop:
- ✅ `dio` - HTTP client
- ✅ `shared_preferences` - Local storage
- ✅ `path_provider` - File paths
- ✅ `url_launcher` - Open URLs
- ✅ `cached_network_image` - Image caching
- ✅ `sqflite` - SQLite database (via `sqflite_common_ffi`) - **NOW SUPPORTS WINDOWS & macOS!**
- ⚠️ `permission_handler` - Limited support on desktop
- ⚠️ `screenshot_callback` - Mobile only (tidak akan berfungsi di desktop)

## Storage & Database

Aplikasi menggunakan SQLite untuk storage lokal yang sekarang **fully cross-platform**.

### Database Locations

**macOS**:
```
~/Library/Application Support/Orbit Digilib/digilib.db
```

**Windows**:
```
C:\Users\{username}\AppData\Local\<app_data>\digilib.db
```

**Linux**:
```
~/.local/share/<app_data>/digilib.db
```

### Stored Data

- **Buku (Books)**: Offline reading history, last page, status
- **Halaman Bintang (Starred Pages)**: Bookmarked pages dalam buku
- **Notifikasi (Notifications)**: Local notification cache

### Important Notes

- Database automatically created on first app run
- User data persists after app closes
- All platform-specific paths handled automatically by `path_provider`
- No special installation required for database

## Testing

### Test di macOS
```bash
flutter run -d macos
```

### Test di Windows (di mesin Windows)
```bash
flutter run -d windows
```

## Catatan Penting

1. **screenshot_callback** tidak support desktop - fitur ini hanya akan berfungsi di mobile
2. **permission_handler** memiliki dukungan terbatas di desktop
3. Pastikan test semua fitur setelah build untuk memastikan kompatibilitas
4. Untuk distribusi publik macOS, Anda memerlukan Apple Developer Account ($99/tahun)
5. Untuk distribusi via Microsoft Store, Anda memerlukan Microsoft Developer Account

## Distribution Checklist

### macOS
- [ ] Test build release di macOS
- [ ] Verifikasi semua fitur berfungsi
- [ ] Sign dengan Developer ID (jika perlu)
- [ ] Notarize aplikasi (jika perlu)
- [ ] Buat DMG atau PKG installer
- [ ] Test installer di mesin clean

### Windows
- [ ] Build di mesin Windows
- [ ] Test build release
- [ ] Verifikasi semua fitur berfungsi
- [ ] Buat installer (Inno Setup atau MSIX)
- [ ] Test installer di mesin clean
- [ ] Sign exe dengan code signing certificate (opsional tapi recommended)
