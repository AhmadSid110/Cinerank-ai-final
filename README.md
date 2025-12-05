<div align="center">
<img width="1200" height="475" alt="GHBanner" src="https://github.com/user-attachments/assets/0aa67016-6eaf-458a-adb2-6e31a0763ed6" />
</div>

# Cinerank AI - Movie & TV Ranking App

This is a React-based web application that helps you discover, rank, and track movies and TV shows using AI-powered search and recommendations.

View your app in AI Studio: https://ai.studio/apps/drive/1MrQA8nZc-_u6rLTX2uW6Tx5Rkde-a2SK

## Run Locally

**Prerequisites:**  Node.js (v16 or higher)

1. Install dependencies:
   ```bash
   npm install
   ```

2. Set the `GEMINI_API_KEY` in [.env.local](.env.local) to your Gemini API key:
   ```
   GEMINI_API_KEY=your_api_key_here
   ```

3. Run the app:
   ```bash
   npm run dev
   ```

4. Open your browser and navigate to `http://localhost:3000`

## Build for Production

To build the web app for production:

```bash
npm run build
```

The built files will be in the `dist` directory.

## Convert to Android APK

Want to run this app on your Android device? Follow our comprehensive mobile build guide!

📱 **See [MOBILE_BUILD_GUIDE.md](MOBILE_BUILD_GUIDE.md) for detailed instructions**

### Quick Start for Mobile Build

1. Install Capacitor dependencies:
   ```bash
   npm install @capacitor/core @capacitor/cli @capacitor/android
   ```

2. Initialize Capacitor (first time only):
   ```bash
   npx cap init
   ```

3. Build and sync to Android:
   ```bash
   npm run cap:sync:android
   ```

4. Open in Android Studio:
   ```bash
   npm run cap:open:android
   ```

5. Build APK in Android Studio or use:
   ```bash
   npm run android:build
   ```

For complete step-by-step instructions, troubleshooting, and signing information, refer to [MOBILE_BUILD_GUIDE.md](MOBILE_BUILD_GUIDE.md).

## Features

- 🎬 Browse trending movies and TV shows
- 🔍 AI-powered search using Gemini
- ⭐ Rate and rank your favorite content
- 📊 Visual analytics and recommendations
- ❤️ Favorites and watchlist management
- 📱 Mobile-ready (can be built as APK)

## Technologies Used

- **React 19** - UI Framework
- **TypeScript** - Type safety
- **Vite** - Build tool
- **Gemini AI** - AI-powered features
- **TMDB API** - Movie/TV data
- **Capacitor** - Mobile app conversion
- **Lucide React** - Icons
- **Recharts** - Data visualization

## API Keys

This app requires two API keys:

1. **TMDB API Key**: Get it from [The Movie Database](https://www.themoviedb.org/settings/api)
2. **Gemini API Key**: Get it from [Google AI Studio](https://makersuite.google.com/app/apikey)

Set these in your `.env.local` file or through the app's settings.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
