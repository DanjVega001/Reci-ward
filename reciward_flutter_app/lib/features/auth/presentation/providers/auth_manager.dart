import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static Future<void> clearAuthenticationInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.remove('token');
    await prefs.clear();
  }
}
