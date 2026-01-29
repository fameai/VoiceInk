#!/bin/bash
# Build and install VoiceInk from source-build branch
#
# Usage: ./scripts/build-local.sh

set -e

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
ENTITLEMENTS="/tmp/VoiceInk-local.entitlements"

cd "$PROJECT_DIR"

# Ensure we're on source-build
BRANCH=$(git branch --show-current)
if [ "$BRANCH" != "source-build" ]; then
    echo -e "${YELLOW}Switching to source-build branch...${NC}"
    git checkout source-build
fi

echo -e "${YELLOW}Building VoiceInk...${NC}"
xcodebuild -project VoiceInk.xcodeproj \
    -scheme VoiceInk \
    -configuration Debug \
    CODE_SIGN_IDENTITY="" \
    build 2>&1 | tail -5

if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo -e "${RED}✗ Build failed${NC}"
    exit 1
fi

# Find the built app
BUILD_DIR="$HOME/Library/Developer/Xcode/DerivedData"
APP_PATH=$(find "$BUILD_DIR" -name "VoiceInk.app" -path "*/Debug/*" -type d 2>/dev/null | head -1)

if [ -z "$APP_PATH" ]; then
    echo -e "${RED}✗ Could not find built app${NC}"
    exit 1
fi

echo -e "${YELLOW}Installing to /Applications...${NC}"
rm -rf /Applications/VoiceInk.app
cp -R "$APP_PATH" /Applications/

# Check for entitlements file
if [ -f "$ENTITLEMENTS" ]; then
    echo "Signing with entitlements..."
    codesign --force --deep --sign - --entitlements "$ENTITLEMENTS" /Applications/VoiceInk.app
else
    echo "Signing (no entitlements file found at $ENTITLEMENTS)..."
    codesign --force --deep --sign - /Applications/VoiceInk.app
fi

echo -e "${GREEN}✓ VoiceInk installed successfully${NC}"
echo ""
echo "Launch with: open /Applications/VoiceInk.app"
