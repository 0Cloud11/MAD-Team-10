import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static Future<void> saveUser({
    required String username,
    required String email,
    required String password,
    required String skillLevel,
    required String progress,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    if (password.isNotEmpty) {
      await prefs.setString('password', password);
    }
    await prefs.setString('skillLevel', skillLevel);
    await prefs.setString('progress', progress);
  }

  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString('username'),
      'email': prefs.getString('email'),
      'password': prefs.getString('password'),
      'skillLevel': prefs.getString('skillLevel'),
      'progress': prefs.getString('progress'),
    };
  }

  static Future<void> setLoginState({
    required bool isLoggedIn,
    required bool keepSignedIn,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', isLoggedIn);
    await prefs.setBool('keep_signed_in', keepSignedIn);
  }
}
