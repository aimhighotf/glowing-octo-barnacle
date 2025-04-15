#!/bin/bash
set -eo pipefail

# Config
ANDROID_SDK_ROOT="$HOME/android-sdk"
BUILD_DIR="$HOME/aimhigh_build"
ARTIFACTS_DIR="$BUILD_DIR/artifacts"

# Setup
mkdir -p "$BUILD_DIR" "$ARTIFACTS_DIR"
cd "$BUILD_DIR"

# Install Android SDK
if [ ! -d "$ANDROID_SDK_ROOT" ]; then
    mkdir -p "$ANDROID_SDK_ROOT"
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
    unzip -q commandlinetools-linux-*.zip -d "$ANDROID_SDK_ROOT"
    mv "$ANDROID_SDK_ROOT/cmdline-tools" "$ANDROID_SDK_ROOT/cmdline-tools/latest"
    yes | "$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager" --install "platform-tools" "build-tools;34.0.0"
fi

# Build
buildozer init
cp ../buildozer.spec .
buildozer -v android debug

# Package
cp bin/*.apk "$ARTIFACTS_DIR/"
echo "Build successful! APK available in $ARTIFACTS_DIR"
