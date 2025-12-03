# Windows Deployment Troubleshooting Guide

## Issue: App Detected as Background Process, Won't Show Window

### Symptom
- Installer runs successfully
- App appears in Task Manager but no window opens
- Application seems to crash silently

### Root Causes

#### 1. SQLite FFI Initialization Error (Most Common)
**Problem**: `sqflite_common_ffi` fails to initialize on desktop platform

**Solution**:
```dart
// In lib/main.dart - Error handling added
if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
  try {
    sqfliteFfiInit();
  } catch (e) {
    debugPrint('Error initializing sqflite FFI: $e');
  }
}
```

#### 2. Database Path Permission Issue
**Problem**: App can't write to AppData folder

**Debugging**:
- Check Windows Event Viewer for errors
- Run app as Administrator to test
- Verify user has write permissions to:
  ```
  C:\Users\{username}\AppData\Local\
  ```

**Solution**:
- If permission denied, installer should run with proper permissions
- Update `windows/installer.iss`:
  ```inno
  PrivilegesRequired=admin
  ```

#### 3. Missing Runtime Dependencies
**Problem**: Visual C++ Runtime or other DLLs missing

**Solution**:
```inno
[Files]
; Add VC++ Runtime if needed
Source: "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Redist\MSVC\v143\vcredist_x64.exe"; DestDir: "{app}"; DestName: "vcredist_x64.exe"

[Run]
; Install VC++ Runtime
Filename: "{app}\vcredist_x64.exe"; Parameters: "/q /norestart"; StatusMsg: "Installing VC++ Runtime..."
```

## Debugging Steps

### 1. Check Console Output
Run from Command Prompt to see actual error:
```batch
cd "C:\Program Files\Orbit Digilib"
digilib.exe
```

### 2. Enable Verbose Logging
Create a test build with verbose output enabled:

**lib/main.dart**:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Add this for debugging
  debugPrintBeginFrame = true;
  debugPrintEndFrame = true;
  
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    try {
      debugPrint('Initializing sqflite FFI...');
      sqfliteFfiInit();
      debugPrint('sqflite FFI initialized successfully');
    } catch (e) {
      debugPrint('ERROR initializing sqflite FFI: $e');
    }
  }
  
  runApp(const MyApp());
}
```

### 3. Check Windows Event Viewer
1. Press `Win + R`
2. Type: `eventvwr.msc`
3. Go to: Windows Logs → Application
4. Look for errors from Flutter or app crashes

### 4. Test Database Access
Create a simple test:

**lib/test_db.dart**:
```dart
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future<void> testDatabasePath() async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    print('App Documents Directory: ${dir.path}');
    
    final dbPath = path.join(dir.path, 'digilib.db');
    print('Database path: $dbPath');
    
    // Try to create/access the database
    final file = File(dbPath);
    if (await file.exists()) {
      print('Database file exists');
    } else {
      print('Database file does not exist (will be created)');
    }
  } catch (e) {
    print('Error testing database: $e');
  }
}
```

Call this in `main()`:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await testDatabasePath(); // Add this
  // ... rest of initialization
}
```

## Common Error Messages

### "Bad state: databaseFactory not initialized"
**Cause**: sqfliteFfiInit() not called before opening database
**Fix**: Ensure it's called in main() before any database operations

### "Access Denied" when opening database
**Cause**: Permission issues or file locked by another process
**Fix**: 
- Run as administrator
- Check if another instance is running
- Ensure AppData folder has write permissions

### "DLL not found"
**Cause**: Missing Visual C++ Runtime
**Fix**: Install Visual C++ Redistributable (usually included with system)

### "Cannot find file"
**Cause**: Wrong database path or folder doesn't exist
**Fix**: `getApplicationDocumentsDirectory()` should create folders automatically

## Prevention Checklist

- [x] Call `sqfliteFfiInit()` before using database (in main.dart)
- [x] Use `try-catch` around database operations
- [x] Add debug print statements for troubleshooting
- [x] Test on clean Windows machine before release
- [x] Verify all plugins are desktop-compatible
- [x] Check installer has proper permissions
- [x] Include error handling in bindings and controllers

## Performance Optimization

For large databases, consider:

```dart
// In SQLHelper.db()
_database = await factory.openDatabase(
  path,
  options: sql.OpenDatabaseOptions(
    version: 1,
    onCreate: (db, version) async {
      await createTables(db);
    },
    onConfigure: (db) async {
      // Enable foreign keys
      await db.execute('PRAGMA foreign_keys = ON');
    },
  ),
);
```

## Testing Before Release

1. **Local Testing**:
   ```bash
   flutter run -d windows
   ```

2. **Release Build Testing**:
   ```bash
   flutter build windows --release
   cd build\windows\runner\Release
   digilib.exe
   ```

3. **Installer Testing**:
   - Build installer: `build_windows.bat release`
   - Test on clean VM or different PC
   - Verify data persists after close/reopen
   - Test offline features (wishlist, starred pages)

4. **Edge Cases**:
   - Test with no internet connection
   - Test with database file deleted
   - Test with corrupted database
   - Test with read-only file permissions

## Support Resources

- Flutter Windows: https://flutter.dev/docs/deployment/windows
- SQLite FFI: https://pub.dev/packages/sqflite_common_ffi
- Path Provider: https://pub.dev/packages/path_provider
- Windows Event Viewer: `eventvwr.msc`

## Still Having Issues?

1. Check `STORAGE_CROSS_PLATFORM_GUIDE.md` for general setup
2. Check `BUILD_WINDOWS_GUIDE.md` for build process
3. Enable verbose logging and share console output
4. Check Windows Event Viewer logs
5. Test database path accessibility manually
