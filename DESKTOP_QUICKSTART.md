# 🚀 Quick Start - Desktop Distribution

Panduan cepat untuk mulai build dan distribusi aplikasi Orbit Digilib ke Windows dan macOS.

## ✅ Apa yang Sudah Disiapkan

1. ✅ **macOS Support** - Fully configured
   - Entitlements sudah diatur untuk network access dan file access
   - Build script siap pakai (`build_macos.sh`)

2. ✅ **Windows Support** - Ready to build
   - CMake configuration sudah ada
   - Build script siap pakai (`build_windows.bat`)
   - Inno Setup installer script (`windows/installer.iss`)

3. ✅ **Documentation**
   - BUILD_DESKTOP.md - Panduan lengkap
   - README.md - Updated dengan info desktop support

## 🎯 Langkah Cepat - macOS (Anda bisa lakukan sekarang!)

### Test Run
```bash
flutter run -d macos
```

### Build Release
```bash
./build_macos.sh release
```

**Output**: `build/macos/Build/Products/Release/digilib.app`

### Jalankan App
```bash
open build/macos/Build/Products/Release/digilib.app
```

### Buat DMG (Optional)
```bash
npm install -g create-dmg
create-dmg 'build/macos/Build/Products/Release/digilib.app'
```

## 🪟 Langkah Cepat - Windows (Perlu mesin Windows)

1. **Transfer project ke Windows machine**
   - Bisa via Git, USB, atau cloud storage

2. **Di Windows, jalankan:**
```cmd
build_windows.bat release
```

3. **Output**: `build\windows\runner\Release\`
   - Folder ini berisi semua file yang perlu didistribusikan

4. **Buat Installer (Optional):**
   - Install [Inno Setup](https://jrsoftware.org/isdl.php)
   - Open `windows/installer.iss` dengan Inno Setup Compiler
   - Click "Compile"
   - Installer akan dibuat di folder `installer_output/`

## 📋 Checklist Sebelum Distribusi

### macOS
- [ ] Test app di macOS (debug mode)
- [ ] Build release
- [ ] Test release build
- [ ] Cek semua fitur berjalan (network, file access, PDF viewer, dll)
- [ ] Buat DMG atau PKG
- [ ] (Optional) Code sign untuk distribusi publik

### Windows  
- [ ] Transfer ke Windows machine
- [ ] Test app di Windows (debug mode)
- [ ] Build release
- [ ] Test release build
- [ ] Cek semua fitur berjalan
- [ ] Buat installer dengan Inno Setup
- [ ] Test installer di clean machine
- [ ] (Optional) Code sign untuk distribusi publik

## ⚠️ Hal Penting yang Perlu Diketahui

### Plugin yang Tidak Berfungsi di Desktop
1. **screenshot_callback** - Mobile only
   - App akan jalan normal, tapi fitur screenshot detection tidak berfungsi di desktop
   
2. **permission_handler** - Limited support
   - Beberapa permissions tidak relevan di desktop

### Plugin yang Bekerja Normal
- ✅ dio (HTTP requests)
- ✅ shared_preferences (settings storage)
- ✅ path_provider (file paths)
- ✅ sqflite (database)
- ✅ syncfusion_flutter_pdfviewer (PDF viewer)
- ✅ cached_network_image (image caching)
- ✅ url_launcher (open URLs)

## 🐛 Troubleshooting

### macOS: "App is damaged and can't be opened"
Ini karena Gatekeeper. Solusi sementara:
```bash
xattr -cr build/macos/Build/Products/Release/digilib.app
```

Untuk distribusi publik, perlu code signing dengan Developer ID.

### Windows: Missing DLL errors
Pastikan semua file di `build\windows\runner\Release\` ter-copy saat distribusi.

### Build error: Plugin not found
Jalankan:
```bash
flutter clean
flutter pub get
```

## 📦 Files untuk Distribusi

### macOS
**Single file:**
- `digilib.app` (bundled app)

**Atau dalam DMG:**
- `OrbitDigilib.dmg` (drag-and-drop installer)

### Windows
**Folder lengkap:**
```
Release/
├── digilib.exe
├── flutter_windows.dll
├── data/
└── [DLL dependencies]
```

**Atau installer:**
- `OrbitDigilibSetup_1.2.1.exe` (single installer file)

## 🎉 Next Steps

1. **Test di macOS sekarang:**
   ```bash
   flutter run -d macos
   ```

2. **Jika OK, build release:**
   ```bash
   ./build_macos.sh release
   ```

3. **Untuk Windows:**
   - Setup Windows development machine
   - Clone/transfer project
   - Run `build_windows.bat release`

## 📞 Support

Untuk pertanyaan lebih lanjut, lihat dokumentasi lengkap di:
- [BUILD_DESKTOP.md](BUILD_DESKTOP.md) - Panduan detail
- [README.md](README.md) - Project overview

---

**Happy Building! 🚀**
