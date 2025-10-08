#!/usr/bin/env bash
set -euo pipefail

# Clean, fetch dependencies, and build a universal release APK.
flutter --version
flutter clean
flutter pub get

# Build a single (non split) release APK for all ABIs
# Note: --split-per-abi is a flag and should not be assigned a value.
flutter build apk --release --target-platform android-arm,android-arm64,android-x64

echo "Universal APK generated at: build/app/outputs/flutter-apk/app-release.apk"
