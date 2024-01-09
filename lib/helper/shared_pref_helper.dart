import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<String?> getValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> saveValue(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  static Future<bool> removeValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }
}
