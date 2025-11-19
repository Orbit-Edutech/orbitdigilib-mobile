#!/bin/bash

# Script untuk build macOS app dengan code signing & DMG
# Usage: ./build_macos.sh [release|debug] [--no-dmg] [--no-sign]

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Default values
BUILD_MODE=${1:-release}
CREATE_DMG=true
SIGN_APP=true

# Parse additional arguments
for arg in "$@"; do
    case $arg in
        --no-dmg) CREATE_DMG=false ;;
        --no-sign) SIGN_APP=false ;;
    esac
done

# Configuration
CERT_NAME="Apple Development: Muhammad Zaky (YX7DC2ASWY)"
APP_NAME="digilib"
DMG_NAME="digilib.dmg"

if [ "$BUILD_MODE" = "release" ]; then
    BUILD_PATH="build/macos/Build/Products/Release/${APP_NAME}.app"
    OUTPUT_DIR="build/macos/Build/Products/Release"
else
    BUILD_PATH="build/macos/Build/Products/Debug/${APP_NAME}.app"
    OUTPUT_DIR="build/macos/Build/Products/Debug"
fi

echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${BLUE}🚀 Orbit Digilib macOS Build Script${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}\n"

echo -e "${YELLOW}📋 Configuration:${NC}"
echo -e "   Build Mode: ${BLUE}$BUILD_MODE${NC}"
echo -e "   Sign App: ${BLUE}$SIGN_APP${NC}"
echo -e "   Create DMG: ${BLUE}$CREATE_DMG${NC}\n"

# Step 1: Clean
echo -e "${YELLOW}1️⃣  Cleaning previous builds...${NC}"
flutter clean
echo -e "${GREEN}✅ Clean complete\n${NC}"

# Step 2: Get dependencies
echo -e "${YELLOW}2️⃣  Getting dependencies...${NC}"
flutter pub get
echo -e "${GREEN}✅ Dependencies updated\n${NC}"

# Step 3: Build
echo -e "${YELLOW}3️⃣  Building macOS app ($BUILD_MODE)...${NC}"
if [ "$BUILD_MODE" = "release" ]; then
    flutter build macos --release
else
    flutter build macos --debug
fi
echo -e "${GREEN}✅ Build complete\n${NC}"

# Step 4: Sign app (if enabled)
if [ "$SIGN_APP" = true ]; then
    echo -e "${YELLOW}4️⃣  Code signing app bundle...${NC}"
    
    # Find certificate hash
    CERT_HASH=$(security find-identity -p basic -v 2>/dev/null | grep "$CERT_NAME" | awk '{print $1}' | tr -d '()')
    
    if [ -z "$CERT_HASH" ]; then
        echo -e "${RED}❌ Certificate not found: $CERT_NAME${NC}"
        echo -e "${YELLOW}Available certificates:${NC}"
        security find-identity -p basic -v
        exit 1
    fi
    
    echo -e "${BLUE}   Using certificate: $CERT_HASH${NC}"
    
    # Remove old signature if exists
    xattr -rd com.apple.quarantine "$BUILD_PATH" 2>/dev/null || true
    
    # Code sign with entitlements
    codesign --deep \
        --force \
        --options runtime \
        --entitlements build/macos/Runner/Release.entitlements \
        --sign "$CERT_HASH" \
        --verbose \
        "$BUILD_PATH"
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ App signing failed!${NC}"
        exit 1
    fi
    
    # Verify signature
    echo -e "${BLUE}   Verifying signature...${NC}"
    codesign --verify --deep --verbose=4 "$BUILD_PATH" > /dev/null 2>&1
    
    echo -e "${GREEN}✅ App signed successfully\n${NC}"
else
    echo -e "${YELLOW}⏭️  Skipping code signing (--no-sign)\n${NC}"
fi

# Step 5: Create DMG (if enabled)
if [ "$CREATE_DMG" = true ]; then
    echo -e "${YELLOW}5️⃣  Creating DMG...${NC}"
    
    # Check if create-dmg is installed
    if ! command -v create-dmg &> /dev/null; then
        echo -e "${RED}❌ create-dmg not found!${NC}"
        echo -e "${YELLOW}Install with: npm install -g create-dmg${NC}\n"
        exit 1
    fi
    
    # Clean old DMG
    if [ -f "$OUTPUT_DIR/$DMG_NAME" ]; then
        echo -e "${BLUE}   Removing old DMG...${NC}"
        rm -f "$OUTPUT_DIR/$DMG_NAME"
    fi
    
    # Create DMG
    if [ "$SIGN_APP" = true ]; then
        echo -e "${BLUE}   Creating signed DMG...${NC}"
        create-dmg \
            --volname "Digilib" \
            --window-pos 200 120 \
            --window-size 800 400 \
            --icon-size 100 \
            --icon "$BUILD_PATH" 200 190 \
            --hide-extension "$BUILD_PATH" \
            --app-drop-link 600 190 \
            --sign "$CERT_HASH" \
            "$OUTPUT_DIR/$DMG_NAME" \
            "$BUILD_PATH"
    else
        echo -e "${BLUE}   Creating unsigned DMG...${NC}"
        create-dmg \
            --volname "Digilib" \
            --window-pos 200 120 \
            --window-size 800 400 \
            --icon-size 100 \
            --icon "$BUILD_PATH" 200 190 \
            --hide-extension "$BUILD_PATH" \
            --app-drop-link 600 190 \
            "$OUTPUT_DIR/$DMG_NAME" \
            "$BUILD_PATH"
    fi
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ DMG creation failed!${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ DMG created successfully\n${NC}"
else
    echo -e "${YELLOW}⏭️  Skipping DMG creation (--no-dmg)\n${NC}"
fi

# Summary
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Build Process Complete!${NC}"
echo -e "${BLUE}════════════════════════════════════════\n${NC}"

echo -e "${YELLOW}📍 Build Artifacts:${NC}"
echo -e "   App: ${GREEN}$BUILD_PATH${NC}"
if [ "$CREATE_DMG" = true ]; then
    echo -e "   DMG: ${GREEN}$OUTPUT_DIR/$DMG_NAME${NC}"
fi

echo -e "\n${YELLOW}🎯 Next Steps:${NC}"
echo -e "   Run app: ${BLUE}open $BUILD_PATH${NC}"
if [ "$CREATE_DMG" = true ]; then
    echo -e "   Test DMG: ${BLUE}hdiutil attach $OUTPUT_DIR/$DMG_NAME${NC}"
fi
if [ "$SIGN_APP" = true ]; then
    echo -e "   Verify: ${BLUE}codesign -v $BUILD_PATH${NC}"
fi

echo -e "\n${YELLOW}📝 Usage Examples:${NC}"
echo -e "   Release build with DMG: ${BLUE}./build_macos.sh release${NC}"
echo -e "   Debug build, no DMG: ${BLUE}./build_macos.sh debug --no-dmg${NC}"
echo -e "   Release, no signing: ${BLUE}./build_macos.sh release --no-sign${NC}\n"