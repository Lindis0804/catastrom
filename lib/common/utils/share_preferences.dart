import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/common/constants/keys.dart';

class SPKeys {
  static const String ACCESS_TOKEN = 'ACCESS_TOKEN';
  static const String USER_ID = 'USER_ID';
}

class SharedPreferencesManager {
  static Future<void> saveString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> removeToken(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<String> getAccessToken() async {
    String spAccessToken =
        await SharedPreferencesManager.getString(SPKeys.ACCESS_TOKEN) ?? '';
    return spAccessToken;
  }
}
