import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.cinerank.ai',
  appName: 'Cinerank AI',
  webDir: 'dist',
  server: {
    androidScheme: 'https',
    // Allow cleartext traffic for development (remove in production)
    cleartext: true
  },
  plugins: {
    SplashScreen: {
      launchShowDuration: 2000,
      backgroundColor: "#000000",
      showSpinner: false,
      androidSpinnerStyle: "small",
      spinnerColor: "#ffffff"
    }
  }
};

export default config;
