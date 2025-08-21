class AppConstants {
  AppConstants._();

  // App Information
  static const String appName = 'KOKKOK Move';
  static const String appVersion = '1.0.0';

  // Grid System
  static const double gridUnit = 8.0;
  static const double spacing4 = gridUnit * 0.5;
  static const double spacing8 = gridUnit;
  static const double spacing12 = gridUnit * 1.5;
  static const double spacing16 = gridUnit * 2;
  static const double spacing20 = gridUnit * 2.5;
  static const double spacing24 = gridUnit * 3;
  static const double spacing32 = gridUnit * 4;
  static const double spacing40 = gridUnit * 5;
  static const double spacing48 = gridUnit * 6;
  static const double spacing56 = gridUnit * 7;
  static const double spacing64 = gridUnit * 8;

  // Border Radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;
  static const double radiusXXLarge = 24.0;

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // API Configuration
  static const String baseUrl = 'https://api.kokkokmove.com';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Map Configuration
  static const double defaultZoom = 15.0;
  static const double maxZoom = 20.0;
  static const double minZoom = 10.0;

  // Ride Configuration
  static const double searchRadius = 5000; // meters
  static const Duration rideSearchTimeout = Duration(minutes: 2);

  // Storage Keys
  static const String keyIsFirstLaunch = 'is_first_launch';
  static const String keyUserToken = 'user_token';
  static const String keyLanguageCode = 'language_code';
  static const String keyThemeMode = 'theme_mode';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyLocationPermission = 'location_permission';

  // Default Values
  static const String defaultLanguage = 'th';
  static const String fallbackLanguage = 'en';
}
