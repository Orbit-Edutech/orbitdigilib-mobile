# Orbit Digilib

A Flutter digital library application.

## Platform Support

This app supports multiple platforms:
- ✅ Android
- ✅ iOS
- ✅ macOS
- ✅ Windows

## Getting Started

### Prerequisites
- Flutter SDK (>=3.2.2 <4.0.0)
- For Android: Android Studio & Android SDK
- For iOS: Xcode & CocoaPods
- For macOS: Xcode & CocoaPods
- For Windows: Visual Studio 2022 with C++ desktop development

### Installation

```bash
flutter pub get
```

### Running the App

#### Mobile
```bash
# Android
flutter run -d android

# iOS
flutter run -d ios
```

#### Desktop
```bash
# macOS
flutter run -d macos

# Windows (on Windows machine)
flutter run -d windows
```

## Building for Distribution

### Mobile Platforms

#### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

### Desktop Platforms

For detailed desktop build instructions, see [BUILD_DESKTOP.md](BUILD_DESKTOP.md)

#### macOS (Quick Build)
```bash
./build_macos.sh release
```

#### Windows (Quick Build - run on Windows machine)
```bash
build_windows.bat release
```

## Project Structure

```
lib/
├── presentation/     # UI screens and controllers
├── utils/           # Utility functions
└── main.dart        # App entry point
```

## Dependencies

Key dependencies include:
- `get` - State management
- `dio` - HTTP client
- `sqflite` - Local database
- `path_provider` - File system access
- `syncfusion_flutter_pdfviewer` - PDF viewing
- `cached_network_image` - Image caching
- And more (see pubspec.yaml)

## Version

Current version: 1.2.1

## Notes

- Some plugins have limited functionality on desktop platforms (e.g., `screenshot_callback` is mobile-only)
- For macOS public distribution, you'll need an Apple Developer account for code signing and notarization
- For Windows public distribution, code signing certificate is recommended