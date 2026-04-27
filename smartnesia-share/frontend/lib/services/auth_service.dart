import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyName = 'userName';
  static const String _keyEmail = 'userEmail';
  static const String _keyIsLoggedIn = 'isLoggedIn';

  static Future<void> saveUser(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyEmail, email);
    await prefs.setBool(_keyIsLoggedIn, true);
  }

  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(_keyName),
      'email': prefs.getString(_keyEmail),
    };
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
