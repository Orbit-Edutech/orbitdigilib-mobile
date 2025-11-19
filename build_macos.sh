#!/bin/bash

# Script untuk build macOS app
# Usage: ./build_macos.sh [release|debug]

set -e

BUILD_MODE=${1:-release}

echo "🚀 Building Orbit Digilib for macOS ($BUILD_MODE)..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build macOS app
echo "🔨 Building macOS app..."
if [ "$BUILD_MODE" = "release" ]; then
    flutter build macos --release
else
    flutter build macos --debug
fi

# Show build location
if [ "$BUILD_MODE" = "release" ]; then
    BUILD_PATH="build/macos/Build/Products/Release/digilib.app"
else
    BUILD_PATH="build/macos/Build/Products/Debug/digilib.app"
fi

echo "✅ Build complete!"
echo "📍 App location: $BUILD_PATH"
echo ""
echo "To run the app:"
echo "  open $BUILD_PATH"
echo ""
echo "To create DMG (requires npm install -g create-dmg):"
echo "  create-dmg '$BUILD_PATH'"
