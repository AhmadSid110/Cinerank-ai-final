# Mobile Build Guide - Converting Cinerank AI to APK

This guide will help you convert the Cinerank AI web application into an Android APK file.

## Overview

This project is a React + Vite web application. To convert it into a mobile app (APK), we'll use **Capacitor** - a modern tool for building cross-platform mobile apps from web projects.

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Node.js** (v16 or higher)
2. **npm** or **yarn**
3. **Android Studio** (for building APK)
   - Download from: https://developer.android.com/studio
   - Install Android SDK (API level 33 or higher recommended)
4. **Java Development Kit (JDK)** 
   - JDK 17 is recommended
   - Ensure `JAVA_HOME` environment variable is set

## Step-by-Step Instructions

### 1. Install Dependencies

First, install all project dependencies:

```bash
npm install
```

### 2. Install Capacitor

Install Capacitor core and CLI:

```bash
npm install @capacitor/core @capacitor/cli
npm install @capacitor/android
```

### 3. Initialize Capacitor

Initialize Capacitor in your project:

```bash
npx cap init
```

When prompted:
- **App name**: Cinerank AI (or your preferred name)
- **App package ID**: com.cinerank.ai (or your preferred reverse domain)
- **Web asset directory**: dist

### 4. Build the Web App

Build the web application for production:

```bash
npm run build
```

This creates optimized files in the `dist` directory.

### 5. Add Android Platform

Add the Android platform to your project:

```bash
npx cap add android
```

This creates an `android` directory with the native Android project.

### 6. Configure Capacitor (Optional)

Edit `capacitor.config.ts` to customize your app settings:

```typescript
import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.cinerank.ai',
  appName: 'Cinerank AI',
  webDir: 'dist',
  server: {
    androidScheme: 'https'
  }
};

export default config;
```

### 7. Sync Web Assets to Android

Copy the built web assets to the native Android project:

```bash
npx cap sync android
```

### 8. Open Android Studio

Open the Android project in Android Studio:

```bash
npx cap open android
```

### 9. Build APK in Android Studio

Once Android Studio opens:

1. Wait for Gradle sync to complete
2. Go to **Build** > **Build Bundle(s) / APK(s)** > **Build APK(s)**
3. Wait for the build to complete
4. Click on **locate** in the notification to find your APK
5. The APK will be in: `android/app/build/outputs/apk/debug/app-debug.apk`

### 10. Alternative: Build from Command Line

You can also build the APK from command line:

```bash
cd android
./gradlew assembleDebug
```

The APK will be located at: `android/app/build/outputs/apk/debug/app-debug.apk`

For a release build (production):

```bash
cd android
./gradlew assembleRelease
```

## Important Notes

### API Keys and Environment Variables

Your app uses API keys (TMDB and Gemini). For the mobile app:

1. **During Development**: Keys stored in `.env.local` will be bundled into the app during build
2. **For Production**: Never commit API keys to version control. Consider:
   - Using a backend API proxy
   - Implementing key obfuscation
   - Using environment-specific builds

### Permissions

If your app needs special permissions (camera, location, etc.), add them to:
`android/app/src/main/AndroidManifest.xml`

Example:
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### App Icons and Splash Screen

1. **App Icon**: Place your icon in `android/app/src/main/res/mipmap-*` folders
2. **Splash Screen**: Configure in `capacitor.config.ts`:

```typescript
{
  plugins: {
    SplashScreen: {
      launchShowDuration: 2000,
      backgroundColor: "#000000",
      showSpinner: false
    }
  }
}
```

### Signing the APK (for Release)

To publish on Google Play Store, you need a signed APK:

1. Generate a keystore:
```bash
keytool -genkey -v -keystore my-release-key.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000
```

2. Configure signing in `android/app/build.gradle`:
```gradle
android {
    signingConfigs {
        release {
            storeFile file('my-release-key.keystore')
            storePassword 'your-password'
            keyAlias 'my-key-alias'
            keyPassword 'your-password'
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

3. Build signed APK:
```bash
cd android
./gradlew assembleRelease
```

## Workflow Summary

For future updates, follow this workflow:

1. Make changes to your web app code
2. Build the web app: `npm run build`
3. Sync to Android: `npx cap sync android`
4. Build APK: `npx cap open android` or `cd android && ./gradlew assembleDebug`

## Quick Commands Reference

```bash
# Install dependencies
npm install

# Install Capacitor
npm install @capacitor/core @capacitor/cli @capacitor/android

# Initialize (first time only)
npx cap init

# Build web app
npm run build

# Add Android (first time only)
npx cap add android

# Sync web assets to Android
npx cap sync android

# Open in Android Studio
npx cap open android

# Build APK from command line
cd android && ./gradlew assembleDebug
```

## Troubleshooting

### Gradle Build Fails
- Ensure Android SDK is properly installed
- Check that `ANDROID_HOME` environment variable is set
- Try cleaning: `cd android && ./gradlew clean`

### App Doesn't Load
- Check that `webDir` in `capacitor.config.ts` matches your build output
- Ensure `npm run build` completed successfully
- Check browser console in app for errors

### API Keys Not Working
- Verify `.env.local` exists before building
- Rebuild the web app: `npm run build`
- Re-sync: `npx cap sync android`

## Additional Resources

- [Capacitor Documentation](https://capacitorjs.com/docs)
- [Android Studio Guide](https://developer.android.com/studio/intro)
- [Building Your First App](https://capacitorjs.com/docs/android)

## Support

For issues specific to Cinerank AI, please open an issue on the GitHub repository.
