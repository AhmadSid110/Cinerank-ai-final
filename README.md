<div align="center">
<img width="1200" height="475" alt="GHBanner" src="https://github.com/user-attachments/assets/0aa67016-6eaf-458a-adb2-6e31a0763ed6" />
</div>

# Run and deploy your AI Studio app

This contains everything you need to run your app locally.

View your app in AI Studio: https://ai.studio/apps/drive/1MrQA8nZc-_u6rLTX2uW6Tx5Rkde-a2SK

## Run Locally

**Prerequisites:**  Node.js


1. Install dependencies:
   `npm install`
2. Set the `GEMINI_API_KEY` in [.env.local](.env.local) to your Gemini API key
3. Run the app:
   `npm run dev`

## 📱 Convert to Android APK

Want to run this app on your Android phone? Check out our guides:

- **[QUICK_START_APK.md](./QUICK_START_APK.md)** - Fast track guide to build your first APK (5 minutes)
- **[APK_BUILD_GUIDE.md](./APK_BUILD_GUIDE.md)** - Complete documentation with multiple methods and troubleshooting

### Quick APK Build Commands

```bash
# Install mobile dependencies
npm install @capacitor/core @capacitor/cli @capacitor/android

# Initialize Capacitor (first time only)
npx cap init "CineRank AI" "com.cinemind.app" --web-dir=dist

# Build and open in Android Studio
npm run build
npx cap add android
npm run android:dev
```

Then in Android Studio: `Build` → `Build APK(s)`

Your APK will be at: `android/app/build/outputs/apk/debug/app-debug.apk`

## 🎯 Features

- 🤖 AI-powered search using Google Gemini
- 🎬 Browse trending movies and TV shows
- ⭐ Save favorites and watchlists
- 🔍 Advanced filtering and discovery
- 📱 Mobile-ready (can be converted to APK)
- 🌐 Progressive Web App (PWA) support
