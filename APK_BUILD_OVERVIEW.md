# APK Build Process Overview

This document provides a high-level overview of how the Cinerank AI web app is converted to an Android APK.

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    Cinerank AI Web App                      │
│                 (React + TypeScript + Vite)                 │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ npm run build
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                   Built Web Assets (dist/)                  │
│              (HTML, CSS, JavaScript bundles)                │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ Capacitor
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                   Native Android Project                    │
│              (Webview wrapper + Capacitor APIs)             │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ Gradle Build
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                      Android APK File                       │
│                (Installable on Android devices)             │
└─────────────────────────────────────────────────────────────┘
```

## Build Process Flow

### Phase 1: Web App Development
```
Source Code (React/TS) → Vite Dev Server → Browser Testing
     │
     └─→ Edit code → Hot reload → Test
```

### Phase 2: Production Build
```
1. npm run build
   ├─→ Vite bundles React components
   ├─→ Transpiles TypeScript to JavaScript
   ├─→ Minifies and optimizes code
   └─→ Outputs to dist/ directory

2. Output Structure:
   dist/
   ├── index.html (Entry point)
   └── assets/
       └── index-[hash].js (Bundled app)
```

### Phase 3: Capacitor Integration
```
1. npx cap init
   └─→ Creates capacitor.config.ts

2. npx cap add android
   ├─→ Creates android/ directory
   ├─→ Generates native Android project
   └─→ Installs Capacitor plugins

3. npx cap sync android
   ├─→ Copies dist/ to android/app/src/main/assets/public/
   ├─→ Updates native project configuration
   └─→ Syncs Capacitor plugins
```

### Phase 4: Android Build
```
1. Android Studio (GUI)
   └─→ Build → Build Bundle(s) / APK(s) → Build APK(s)

   OR

2. Command Line (CLI)
   └─→ ./gradlew assembleDebug (or assembleRelease)

3. Output:
   android/app/build/outputs/apk/
   ├── debug/
   │   └── app-debug.apk
   └── release/
       └── app-release.apk
```

## Technology Stack

### Web Layer
- **React 19**: UI framework
- **TypeScript**: Type-safe development
- **Vite**: Build tool & dev server
- **Tailwind CSS**: Styling (via CDN)

### API Integration
- **Gemini AI**: AI-powered features
- **TMDB API**: Movie/TV data

### Mobile Layer
- **Capacitor**: Web-to-native bridge
- **Android WebView**: Renders web content
- **Gradle**: Android build system

### Build Tools
- **npm**: Package management
- **Vite**: Web bundling
- **Gradle**: Android compilation
- **Android SDK**: Platform tools

## File Structure After Setup

```
cinerank-ai-final/
├── src/                          # Source code (React/TS)
│   ├── App.tsx
│   ├── index.tsx
│   └── components/
├── dist/                         # Built web assets (generated)
│   ├── index.html
│   └── assets/
│       └── index-[hash].js
├── android/                      # Native Android project (generated)
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── assets/public/   # Synced web assets
│   │   │   ├── AndroidManifest.xml
│   │   │   └── java/
│   │   └── build.gradle
│   ├── gradle/
│   └── build.gradle
├── capacitor.config.ts          # Capacitor configuration
├── package.json                 # Dependencies & scripts
├── vite.config.ts              # Vite configuration
├── MOBILE_BUILD_GUIDE.md       # Detailed instructions
├── QUICK_REFERENCE.md          # Quick commands
├── TROUBLESHOOTING.md          # Common issues
└── build-android.sh            # Build automation script
```

## Key Configuration Files

### capacitor.config.ts
```typescript
{
  appId: 'com.cinerank.ai',      // Android package ID
  appName: 'Cinerank AI',         // App display name
  webDir: 'dist',                 // Built web assets location
  server: {
    androidScheme: 'https'        // URL scheme for loading
  }
}
```

### package.json (scripts)
```json
{
  "scripts": {
    "build": "vite build",                    // Build web app
    "cap:sync:android": "npm run build && cap sync android",  // Build & sync
    "cap:open:android": "cap open android",   // Open in Android Studio
    "android:build": "... && ./gradlew assembleDebug"  // Full build
  }
}
```

## Development Workflow

### First-Time Setup
```bash
1. npm install                   # Install dependencies
2. npx cap init                  # Initialize Capacitor
3. npx cap add android          # Add Android platform
4. npm run build                # Build web app
5. npx cap sync android         # Sync to Android
6. npx cap open android         # Open in Android Studio
```

### Regular Development Cycle
```bash
# Option A: Web development
npm run dev                     # Develop & test in browser
npm run build                   # Build when ready

# Option B: Mobile development
npm run build                   # Build web app
npx cap sync android           # Sync to Android
npx cap open android           # Test in Android Studio
```

### Making Changes
```bash
Edit code → npm run build → npx cap sync android → Rebuild APK
```

## Build Variants

### Debug Build
- **Purpose**: Development & testing
- **Signing**: Debug keystore (auto-generated)
- **Optimizations**: Minimal
- **Command**: `./gradlew assembleDebug`
- **Output**: `app-debug.apk`
- **Size**: Larger (includes debugging info)

### Release Build
- **Purpose**: Production distribution
- **Signing**: Custom keystore (required)
- **Optimizations**: Full minification & obfuscation
- **Command**: `./gradlew assembleRelease`
- **Output**: `app-release.apk`
- **Size**: Smaller (optimized)

## Prerequisites Checklist

- [ ] Node.js v16+ installed
- [ ] npm or yarn installed
- [ ] Android Studio installed
- [ ] Android SDK (API 33+) installed
- [ ] JDK 17 installed
- [ ] ANDROID_HOME environment variable set
- [ ] JAVA_HOME environment variable set
- [ ] Adequate disk space (~5GB for Android SDK)
- [ ] Internet connection (for downloading dependencies)

## Quick Command Reference

| Task | Command |
|------|---------|
| Install dependencies | `npm install` |
| Build web app | `npm run build` |
| Initialize Capacitor | `npx cap init` |
| Add Android | `npx cap add android` |
| Sync to Android | `npx cap sync android` |
| Open Android Studio | `npx cap open android` |
| Build debug APK | `cd android && ./gradlew assembleDebug` |
| Build release APK | `cd android && ./gradlew assembleRelease` |
| Clean build | `cd android && ./gradlew clean` |
| All-in-one build | `./build-android.sh` |

## Common Use Cases

### 1. First-Time APK Creation
Follow: MOBILE_BUILD_GUIDE.md (complete instructions)

### 2. Quick Build After Code Changes
```bash
npm run android:build
```

### 3. Testing Changes
```bash
npm run dev  # Test in browser first
# Then build APK if working
```

### 4. Production Release
```bash
npm run android:release
# Sign with production keystore
```

## Resources & Links

- **Main Guide**: [MOBILE_BUILD_GUIDE.md](MOBILE_BUILD_GUIDE.md)
- **Quick Reference**: [QUICK_REFERENCE.md](QUICK_REFERENCE.md)
- **Troubleshooting**: [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Capacitor Docs**: https://capacitorjs.com/docs
- **Android Developer**: https://developer.android.com/
- **Vite Docs**: https://vitejs.dev/
