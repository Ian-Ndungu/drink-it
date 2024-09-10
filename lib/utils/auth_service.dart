import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Admin credentials for testing
  static const String adminEmail = 'admin@gmail.com';
  static const String adminPassword = 'admin123';

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<bool> isAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAdmin') ?? false;
  }

  static Future<void> login(String email, String password, {bool admin = false}) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if the provided credentials match the admin credentials
    bool isAdmin = (email == adminEmail && password == adminPassword) || admin;

    // Simulate a login process and store user info
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);
    await prefs.setBool('isAdmin', isAdmin);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('email');
    await prefs.remove('isAdmin');
  }
}
