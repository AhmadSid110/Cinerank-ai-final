# Quick Reference - Building Android APK

This is a quick reference guide for converting Cinerank AI web app to an Android APK.

## One-Time Setup

```bash
# 1. Install all dependencies (including Capacitor)
npm install

# 2. Install Capacitor if not already installed
npm install @capacitor/core @capacitor/cli @capacitor/android

# 3. Initialize Capacitor (first time only)
npx cap init "Cinerank AI" "com.cinerank.ai" --web-dir=dist

# 4. Add Android platform (first time only)
npx cap add android
```

## Build APK (Every Time You Make Changes)

### Option 1: Using Automated Script

**Linux/Mac:**
```bash
./build-android.sh
```

**Windows:**
```bash
build-android.bat
```

### Option 2: Manual Steps

```bash
# 1. Build the web app
npm run build

# 2. Sync to Android
npx cap sync android

# 3. Open in Android Studio (then build APK from there)
npx cap open android
```

### Option 3: Command Line Build (Requires Android SDK)

```bash
# Build debug APK
npm run android:build

# Or manually:
cd android
./gradlew assembleDebug

# For release build:
./gradlew assembleRelease
```

## Useful npm Scripts

```bash
# Build web app only
npm run build

# Build and sync to Android
npm run cap:sync:android

# Open Android project in Android Studio
npm run cap:open:android

# Complete build (web + sync + APK)
npm run android:build

# Production release build
npm run android:release
```

## Finding Your APK

After building, find your APK at:

**Debug APK:**
```
android/app/build/outputs/apk/debug/app-debug.apk
```

**Release APK:**
```
android/app/build/outputs/apk/release/app-release.apk
```

## Quick Troubleshooting

**Problem:** `cap: command not found`
**Solution:** Install Capacitor CLI: `npm install @capacitor/cli`

**Problem:** `gradlew: command not found`
**Solution:** Make sure you're in the `android` directory and Android SDK is installed

**Problem:** App doesn't load / blank screen
**Solution:** 
1. Run `npm run build`
2. Run `npx cap sync android`
3. Rebuild the APK

**Problem:** API keys not working in mobile app
**Solution:** Make sure `.env.local` exists before building, then rebuild and sync

## Requirements

- **Node.js** v16+ 
- **npm** or **yarn**
- **Android Studio** (for building APK)
- **Android SDK** (API 33+ recommended)
- **JDK** 17 (for Android builds)

## Additional Help

For detailed instructions, see [MOBILE_BUILD_GUIDE.md](MOBILE_BUILD_GUIDE.md)
