# Cross-Platform SQLite Storage Support

## Problem
Aplikasi menggunakan `sqflite` untuk mengelola database lokal, namun `sqflite` hanya mendukung platform Android dan iOS. Support untuk Windows dan macOS tidak tersedia.

## Solusi
Ditambahkan `sqflite_common_ffi` yang memungkinkan penggunaan SQLite di desktop platforms (Windows, macOS, Linux) menggunakan FFI (Foreign Function Interface).

## Perubahan yang Dilakukan

### 1. Update `pubspec.yaml`
Ditambahkan dependency:
```yaml
sqflite_common_ffi: ^2.3.0
```

### 2. Update `lib/main.dart`
Inisialisasi FFI untuk platform desktop sebelum menjalankan app:
```dart
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    sqfliteFfiInit();
  }
  
  runApp(const MyApp());
  ImageUtils.prechacheImages();
}
```

### 3. Update `lib/sql/sql_helper.dart`
Perubahan signifikan:
- **Database caching**: Menggunakan static variable `_database` untuk menghindari opening database berkali-kali
- **Platform-specific paths**:
  - Android/iOS: Menggunakan `sql.getDatabasesPath()` (path khusus platform mobile)
  - Desktop (Windows/macOS/Linux): Menggunakan `getApplicationDocumentsDirectory()` untuk path yang appropriate
- **Table creation safety**: Menambahkan `IF NOT EXISTS` pada semua CREATE TABLE statements
- **Close method**: Menambahkan method `close()` untuk cleanup database connection

#### Database Paths:
- **Android**: `/data/data/package_name/databases/digilib.db`
- **iOS**: `Documents/digilib.db`
- **Windows**: `C:\Users\{username}\AppData\Local\{app}\Documents\digilib.db`
- **macOS**: `~/Library/Application Support/{app}/digilib.db`
- **Linux**: `~/.local/share/{app}/digilib.db`

## Platform Compatibility
✅ Android  
✅ iOS  
✅ Windows  
✅ macOS  
✅ Linux  

## Testing
Untuk testing cross-platform:

### Windows Build:
```bash
flutter build windows
# atau run dev
flutter run -d windows
```

### macOS Build:
```bash
flutter build macos
# atau run dev
flutter run -d macos
```

### Mobile (for verification):
```bash
flutter run -d android
flutter run -d ios
```

## Important Notes
1. Database file akan automatically dibuat di lokasi yang sesuai untuk masing-masing platform
2. Tidak perlu menambahkan permission khusus karena menggunakan standard application directories
3. Database akan persistent setelah app di-close dan re-open
4. Semua existing fitur SQLite (wishlist, starred pages, notifications) akan bekerja di semua platform

## Troubleshooting
Jika menemukan error "sqflite_common_ffi not found":
```bash
flutter pub get
flutter pub cache repair
flutter clean
```

Jika database corruption:
```bash
# Delete app data (dev environment)
# Database akan recreated automatically pada startup berikutnya
```
