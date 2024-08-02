import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    // Simulate a login process and store user info
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('email');
  }
}
