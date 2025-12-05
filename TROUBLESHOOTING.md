# Troubleshooting Guide - Android APK Build

This guide covers common issues you might encounter when converting Cinerank AI to an Android APK and their solutions.

## Common Issues and Solutions

### 1. Build Issues

#### Problem: "vite: command not found" or "npm: command not found"
**Solution:**
```bash
# Install Node.js from https://nodejs.org/
# Then verify installation:
node --version
npm --version

# Reinstall dependencies:
npm install
```

#### Problem: Build fails with "out of memory" error
**Solution:**
```bash
# Increase Node.js memory limit:
export NODE_OPTIONS=--max_old_space_size=4096
npm run build
```

#### Problem: "dist directory not found"
**Solution:**
```bash
# Make sure build completed successfully:
npm run build

# Check if dist folder exists:
ls -la dist/
```

### 2. Capacitor Issues

#### Problem: "cap: command not found"
**Solution:**
```bash
# Install Capacitor CLI:
npm install @capacitor/cli

# Or use npx to run without global install:
npx cap --version
```

#### Problem: "Capacitor not initialized"
**Solution:**
```bash
# Initialize Capacitor:
npx cap init "Cinerank AI" "com.cinerank.ai" --web-dir=dist
```

#### Problem: "Android platform not found"
**Solution:**
```bash
# Add Android platform:
npx cap add android

# If already added but corrupted, remove and re-add:
rm -rf android
npx cap add android
```

### 3. Android Build Issues

#### Problem: "ANDROID_HOME not set"
**Solution:**

**Linux/Mac:**
```bash
# Add to ~/.bashrc or ~/.zshrc:
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

**Windows:**
```bash
# Set environment variables:
setx ANDROID_HOME "C:\Users\YourUsername\AppData\Local\Android\Sdk"
```

#### Problem: "JAVA_HOME not set" or "JDK not found"
**Solution:**

**Linux/Mac:**
```bash
# Install OpenJDK 17:
sudo apt install openjdk-17-jdk  # Ubuntu/Debian
brew install openjdk@17          # macOS

# Set JAVA_HOME:
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64  # Linux
export JAVA_HOME=/usr/local/opt/openjdk@17           # macOS
```

**Windows:**
```bash
# Download JDK from https://adoptium.net/
# Set JAVA_HOME in environment variables
```

#### Problem: "gradlew: command not found"
**Solution:**
```bash
# Make sure you're in the android directory:
cd android

# Make gradlew executable (Linux/Mac):
chmod +x gradlew

# Then run:
./gradlew assembleDebug
```

#### Problem: Gradle build fails with "SDK not found"
**Solution:**
```bash
# Install Android SDK through Android Studio
# Or use sdkmanager:
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"
```

### 4. App Runtime Issues

#### Problem: App shows blank white screen
**Solution:**
1. Check that build was successful:
   ```bash
   npm run build
   ls dist/  # Should show index.html and assets folder
   ```

2. Re-sync to Android:
   ```bash
   npx cap sync android
   ```

3. Rebuild the APK

4. Check Android Studio's Logcat for errors

#### Problem: API keys not working in mobile app
**Solution:**
1. Ensure `.env.local` exists with correct keys:
   ```bash
   cat .env.local
   # Should show: GEMINI_API_KEY=your_key_here
   ```

2. Rebuild from scratch:
   ```bash
   npm run build
   npx cap sync android
   # Then rebuild APK
   ```

3. For production, consider using a backend proxy for API keys

#### Problem: App crashes on startup
**Solution:**
1. Check Android Studio Logcat for error messages
2. Verify AndroidManifest.xml has internet permission:
   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   ```
3. Check that capacitor.config.ts is configured correctly
4. Try cleaning and rebuilding:
   ```bash
   cd android
   ./gradlew clean
   ./gradlew assembleDebug
   ```

### 5. Network and API Issues

#### Problem: "Network request failed" in mobile app
**Solution:**
1. Add internet permission to AndroidManifest.xml
2. Check that `cleartext` is enabled in capacitor.config.ts for development:
   ```typescript
   server: {
     androidScheme: 'https',
     cleartext: true  // Only for development
   }
   ```

#### Problem: CORS errors in mobile app
**Solution:**
Mobile apps typically don't have CORS issues. If you see this:
1. Make sure you're testing on actual device/emulator
2. Check that API endpoints support the domain or are public
3. Verify API keys are correct

### 6. Signing and Release Issues

#### Problem: "keystore not found" when signing
**Solution:**
```bash
# Generate a new keystore:
keytool -genkey -v -keystore my-release-key.keystore \
  -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000

# Move it to android/app/:
mv my-release-key.keystore android/app/
```

#### Problem: "jarsigner: unable to sign jar"
**Solution:**
1. Verify keystore password is correct
2. Check keystore alias matches configuration
3. Ensure keystore file is in correct location

### 7. File Size Issues

#### Problem: APK size is too large
**Solution:**
1. Enable ProGuard/R8 in android/app/build.gradle:
   ```gradle
   buildTypes {
       release {
           minifyEnabled true
           shrinkResources true
           proguardFiles getDefaultProguardFile('proguard-android-optimize.txt')
       }
   }
   ```

2. Use Android App Bundle (.aab) instead of APK:
   ```bash
   ./gradlew bundleRelease
   ```

3. Split APKs by ABI:
   ```gradle
   splits {
       abi {
           enable true
           reset()
           include 'armeabi-v7a', 'arm64-v8a', 'x86', 'x86_64'
           universalApk false
       }
   }
   ```

### 8. Development Workflow Issues

#### Problem: Changes not showing up in mobile app
**Solution:**
Every time you make code changes:
```bash
# 1. Rebuild web app
npm run build

# 2. Sync to Android
npx cap sync android

# 3. Rebuild APK (or hot reload if using live reload)
cd android && ./gradlew assembleDebug
```

#### Problem: Live reload not working
**Solution:**
For development with live reload:
```bash
# 1. Start dev server:
npm run dev

# 2. Update capacitor.config.ts:
server: {
  url: 'http://192.168.1.100:3000',  # Your local IP
  cleartext: true
}

# 3. Sync and rebuild:
npx cap sync android
```

## Getting Help

If you're still stuck:

1. **Check the logs:**
   - Web: Browser console (F12)
   - Android: Android Studio Logcat
   - Build: Check terminal output carefully

2. **Verify setup:**
   ```bash
   node --version        # Should be v16+
   npm --version
   npx cap doctor        # Checks Capacitor setup
   ```

3. **Start fresh:**
   ```bash
   # Remove build artifacts
   rm -rf dist/ android/ node_modules/
   
   # Reinstall and rebuild
   npm install
   npm run build
   npx cap add android
   npx cap sync android
   ```

4. **Resources:**
   - [Capacitor Documentation](https://capacitorjs.com/docs)
   - [Android Developer Docs](https://developer.android.com/docs)
   - [Vite Documentation](https://vitejs.dev/)

5. **Open an issue:**
   - If you believe there's a bug in the setup, open an issue on GitHub
   - Include your error messages, OS, Node version, and steps to reproduce

## Prevention Tips

- Always run `npm run build` before syncing to Android
- Keep your dependencies up to date: `npm update`
- Test on actual devices, not just emulators
- Use version control to track working states
- Document any custom changes you make
- Keep backups of your keystore file (for release builds)

## Quick Diagnostic Commands

```bash
# Check Node and npm
node --version && npm --version

# Check Capacitor setup
npx cap doctor

# Check Android SDK
echo $ANDROID_HOME
ls $ANDROID_HOME/platforms

# Check Java
java -version
echo $JAVA_HOME

# Verify build output
ls -la dist/

# Check Android project
ls -la android/

# Clean everything and start fresh
rm -rf dist/ android/ node_modules/ package-lock.json
npm install
```
