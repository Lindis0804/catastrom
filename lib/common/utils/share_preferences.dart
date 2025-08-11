import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/models/user/user.model.dart';

class SPKeys {
  static const String ACCESS_TOKEN = 'ACCESS_TOKEN';
  static const String USER_ID = 'USER_ID',
      USER_PROFILE = 'USER_PROFILE',
      REFRESH_TOKEN = 'REFRESH_TOKEN';
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

  static Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userjson = prefs.getString(SPKeys.USER_PROFILE);
    if (userjson == null) {
      return null;
    }
    Map<String, dynamic> userMap = jsonDecode(userjson);
    return User.fromJson(userMap);
  }
}
