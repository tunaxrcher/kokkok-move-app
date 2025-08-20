import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../../core/constants/app_constants.dart';
import 'dart:convert';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // User data
  Future<void> saveUser(User user) async {
    await _prefs.setString('user_data', jsonEncode(user.toJson()));
  }

  User? getUser() {
    final userData = _prefs.getString('user_data');
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }

  Future<void> clearUser() async {
    await _prefs.remove('user_data');
  }

  // Authentication token
  Future<void> saveToken(String token) async {
    await _prefs.setString(AppConstants.keyUserToken, token);
  }

  String? getToken() {
    return _prefs.getString(AppConstants.keyUserToken);
  }

  Future<void> clearToken() async {
    await _prefs.remove(AppConstants.keyUserToken);
  }

  // Language
  Future<void> saveLanguage(String languageCode) async {
    await _prefs.setString(AppConstants.keyLanguageCode, languageCode);
  }

  String getLanguage() {
    return _prefs.getString(AppConstants.keyLanguageCode) ??
        AppConstants.defaultLanguage;
  }

  // Theme
  Future<void> saveThemeMode(String themeMode) async {
    await _prefs.setString(AppConstants.keyThemeMode, themeMode);
  }

  String getThemeMode() {
    return _prefs.getString(AppConstants.keyThemeMode) ?? 'dark';
  }

  // Notifications
  Future<void> saveNotificationsEnabled(bool enabled) async {
    await _prefs.setBool(AppConstants.keyNotificationsEnabled, enabled);
  }

  bool getNotificationsEnabled() {
    return _prefs.getBool(AppConstants.keyNotificationsEnabled) ?? true;
  }

  // First launch
  Future<void> setFirstLaunchCompleted() async {
    await _prefs.setBool(AppConstants.keyIsFirstLaunch, false);
  }

  bool isFirstLaunch() {
    return _prefs.getBool(AppConstants.keyIsFirstLaunch) ?? true;
  }

  // Location permission
  Future<void> saveLocationPermission(bool granted) async {
    await _prefs.setBool(AppConstants.keyLocationPermission, granted);
  }

  bool getLocationPermission() {
    return _prefs.getBool(AppConstants.keyLocationPermission) ?? false;
  }

  // Clear all data
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
