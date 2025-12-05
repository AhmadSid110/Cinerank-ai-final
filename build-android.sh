#!/bin/bash

# Cinerank AI - Android APK Build Script
# This script automates the process of building an Android APK from the web app

set -e  # Exit on error

echo "=========================================="
echo "Cinerank AI - Android APK Build Script"
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${GREEN}[STEP]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install Node.js v16 or higher."
    exit 1
fi

print_step "Node.js version: $(node --version)"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    print_error "npm is not installed. Please install npm."
    exit 1
fi

print_step "npm version: $(npm --version)"

# Install dependencies
print_step "Installing project dependencies..."
npm install

# Check if Capacitor is installed
if ! npm list @capacitor/cli &> /dev/null; then
    print_step "Installing Capacitor..."
    npm install @capacitor/core @capacitor/cli @capacitor/android
fi

# Check if Capacitor is initialized
if [ ! -f "capacitor.config.ts" ] && [ ! -f "capacitor.config.json" ]; then
    print_warning "Capacitor not initialized. Initializing now..."
    echo ""
    echo "Please provide the following information:"
    echo ""
    
    read -p "App name (default: Cinerank AI): " APP_NAME
    APP_NAME=${APP_NAME:-"Cinerank AI"}
    
    read -p "App package ID (default: com.cinerank.ai): " APP_ID
    APP_ID=${APP_ID:-"com.cinerank.ai"}
    
    npx cap init "$APP_NAME" "$APP_ID" --web-dir=dist
    
    print_step "Capacitor initialized successfully!"
fi

# Build the web app
print_step "Building web application..."
npm run build

if [ ! -d "dist" ]; then
    print_error "Build failed. dist directory not found."
    exit 1
fi

print_step "Web app built successfully!"

# Check if Android platform is added
if [ ! -d "android" ]; then
    print_step "Adding Android platform..."
    npx cap add android
    print_step "Android platform added successfully!"
else
    print_step "Android platform already exists."
fi

# Sync web assets to Android
print_step "Syncing web assets to Android..."
npx cap sync android

print_step "Sync completed successfully!"

echo ""
echo "=========================================="
echo -e "${GREEN}Setup Complete!${NC}"
echo "=========================================="
echo ""
echo "Next steps:"
echo ""
echo "1. To open the project in Android Studio:"
echo "   npx cap open android"
echo ""
echo "2. To build APK from command line (requires Android SDK):"
echo "   cd android && ./gradlew assembleDebug"
echo ""
echo "3. The APK will be located at:"
echo "   android/app/build/outputs/apk/debug/app-debug.apk"
echo ""
echo "For detailed instructions, see MOBILE_BUILD_GUIDE.md"
echo ""
