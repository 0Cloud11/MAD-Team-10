import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static const String keyUsername = 'username';
  static const String keyEmail = 'email';
  static const String keyPassword = 'password';
  static const String keySkillLevel = 'skill_level';
  static const String keyProgress = 'progress';
  static const String keyKeepSignedIn = 'keep_signed_in';
  static const String keyIsLoggedIn = 'is_logged_in';

  static Future<void> saveUser({
    required String username,
    required String email,
    required String password,
    String skillLevel = 'Beginner',
    String progress = '0% Completed',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUsername, username);
    await prefs.setString(keyEmail, email);
    await prefs.setString(keyPassword, password);
    await prefs.setString(keySkillLevel, skillLevel);
    await prefs.setString(keyProgress, progress);
  }

  static Future<Map<String, String>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString(keyUsername) ?? 'Demo User',
      'email': prefs.getString(keyEmail) ?? 'demo@user.com',
      'password': prefs.getString(keyPassword) ?? '',
      'skillLevel': prefs.getString(keySkillLevel) ?? 'Beginner',
      'progress': prefs.getString(keyProgress) ?? '0% Completed',
    };
  }

  static Future<void> updateProfile({
    required String username,
    required String email,
    required String skillLevel,
    required String progress,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUsername, username);
    await prefs.setString(keyEmail, email);
    await prefs.setString(keySkillLevel, skillLevel);
    await prefs.setString(keyProgress, progress);
  }

  static Future<void> setLoginState({
    required bool isLoggedIn,
    required bool keepSignedIn,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLoggedIn, isLoggedIn);
    await prefs.setBool(keyKeepSignedIn, keepSignedIn);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLoggedIn, false);
    await prefs.setBool(keyKeepSignedIn, false);
  }
}
