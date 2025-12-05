@echo off
REM Cinerank AI - Android APK Build Script (Windows)
REM This script automates the process of building an Android APK from the web app

echo ==========================================
echo Cinerank AI - Android APK Build Script
echo ==========================================
echo.

REM Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js is not installed. Please install Node.js v16 or higher.
    exit /b 1
)

echo [STEP] Node.js version:
node --version

REM Check if npm is installed
where npm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] npm is not installed. Please install npm.
    exit /b 1
)

echo [STEP] npm version:
npm --version

REM Install dependencies
echo [STEP] Installing project dependencies...
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to install dependencies
    exit /b 1
)

REM Check if Capacitor is installed
echo [STEP] Checking Capacitor installation...
call npm list @capacitor/cli >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [STEP] Installing Capacitor...
    call npm install @capacitor/core @capacitor/cli @capacitor/android
)

REM Check if Capacitor is initialized
if not exist "capacitor.config.ts" if not exist "capacitor.config.json" (
    echo [WARNING] Capacitor not initialized. Initializing now...
    echo.
    echo Please provide the following information:
    echo.
    
    set /p APP_NAME="App name (default: Cinerank AI): "
    if "%APP_NAME%"=="" set APP_NAME=Cinerank AI
    
    set /p APP_ID="App package ID (default: com.cinerank.ai): "
    if "%APP_ID%"=="" set APP_ID=com.cinerank.ai
    
    call npx cap init "%APP_NAME%" "%APP_ID%" --web-dir=dist
    echo [STEP] Capacitor initialized successfully!
)

REM Build the web app
echo [STEP] Building web application...
call npm run build
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Build failed
    exit /b 1
)

if not exist "dist" (
    echo [ERROR] Build failed. dist directory not found.
    exit /b 1
)

echo [STEP] Web app built successfully!

REM Check if Android platform is added
if not exist "android" (
    echo [STEP] Adding Android platform...
    call npx cap add android
    echo [STEP] Android platform added successfully!
) else (
    echo [STEP] Android platform already exists.
)

REM Sync web assets to Android
echo [STEP] Syncing web assets to Android...
call npx cap sync android
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Sync failed
    exit /b 1
)

echo [STEP] Sync completed successfully!

echo.
echo ==========================================
echo Setup Complete!
echo ==========================================
echo.
echo Next steps:
echo.
echo 1. To open the project in Android Studio:
echo    npx cap open android
echo.
echo 2. To build APK from command line (requires Android SDK):
echo    cd android ^&^& gradlew.bat assembleDebug
echo.
echo 3. The APK will be located at:
echo    android\app\build\outputs\apk\debug\app-debug.apk
echo.
echo For detailed instructions, see MOBILE_BUILD_GUIDE.md
echo.

pause
