#!/bin/bash

# Check if the flavor argument is passed
if [ -z "$1" ]; then
  echo "No flavor specified. Usage: ./generate_flutter_android_apk.sh [dev|uat|prod]"
  exit 1
fi

FLAVOR=$1

# Function to build the specified flavor for Android
build_android() {
  case $FLAVOR in
    dev)
      flutter build apk --release --flavor dev --dart-define=ENV=dev -t lib/main.dart
      ;;
    uat)
      flutter build apk --release --flavor uat --dart-define=ENV=uat -t lib/main.dart
      ;;
    prod)
      flutter build apk --release --flavor prod --dart-define=ENV=prod -t lib/main.dart
      ;;
    *)
      echo "Invalid flavor specified. Usage: ./generate_flutter_android_apk.sh [dev|uat|prod]"
      exit 1
      ;;
  esac
}

# Function to build the specified flavor for iOS
build_ios() { 
  case $FLAVOR in
    dev)
      flutter build ios --flavor dev -t lib/main.dart --no-sound-null-safety
      ;;
    uat)
      flutter build ios --flavor uat -t lib/main.dart --no-sound-null-safety --shrink --obfuscate --split-debug-info=build/app/outputs/symbols
      ;;
    prod)
      flutter build ios --flavor prod -t lib/main.dart --no-sound-null-safety --shrink --obfuscate --split-debug-info=build/app/outputs/symbols
      ;;
    *)
      echo "Invalid flavor specified. Usage: ./generate_flutter_android_apk.sh [dev|uat|prod]"
      exit 1
      ;;
  esac
}

# Build for Android
build_android

# Build for iOS
build_ios

echo "Build for $FLAVOR completed successfully."
