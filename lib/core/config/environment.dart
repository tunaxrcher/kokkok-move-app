class Environment {
  Environment._();

  // Google Maps API Keys (replace with your actual keys)
  static const String googleMapsApiKeyAndroid = 'YOUR_ANDROID_API_KEY_HERE';
  static const String googleMapsApiKeyIOS = 'YOUR_IOS_API_KEY_HERE';
  static const String googleMapsApiKeyWeb = 'YOUR_WEB_API_KEY_HERE';

  // Google Sign-In Client IDs
  static const String googleSignInWebClientId =
      'YOUR_GOOGLE_SIGNIN_WEB_CLIENT_ID_HERE';

  // API Configuration
  static const String baseApiUrl = 'https://api.kokkokmove.com';
  static const bool isProduction = false;
  static const bool enableLogging = true;
}

// Instructions for setting up API keys:
/*
1. WEB (web/index.html):
   Replace: <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY_HERE&libraries=places"></script>
   With:    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_ACTUAL_WEB_KEY&libraries=places"></script>

2. ANDROID (android/app/src/main/AndroidManifest.xml):
   Replace: android:value="YOUR_ANDROID_API_KEY_HERE"
   With:    android:value="YOUR_ACTUAL_ANDROID_KEY"

3. iOS (ios/Runner/AppDelegate.swift):
   Replace: GMSServices.provideAPIKey("YOUR_IOS_API_KEY_HERE")
   With:    GMSServices.provideAPIKey("YOUR_ACTUAL_IOS_KEY")

4. Google Sign-In Web (web/index.html):
   Add: <meta name="google-signin-client_id" content="YOUR_GOOGLE_SIGNIN_WEB_CLIENT_ID" />

Note: You can use the same API key for all platforms if it's configured properly in Google Cloud Console.
*/
