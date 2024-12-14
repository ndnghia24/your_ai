import 'package:shared_preferences/shared_preferences.dart';
import 'spref_key.dart';

class SPref {
  static final SPref instance = SPref._internal();
  SPref._internal();

  /// Jarvis Auth

  Future<String?> getJarvisAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SPrefKey.keyJarvisAccessToken);
  }

  Future setJarvisAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefKey.keyJarvisAccessToken, token);
  }

  Future<String?> getJarvisRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SPrefKey.keyJarvisRefreshToken);
  }

  Future setJarvisRefreshToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefKey.keyJarvisRefreshToken, token);
  }

  /// Jarvis Auth

  Future<String?> getKBAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SPrefKey.keyKBAccessToken);
  }

  Future setKBAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefKey.keyKBAccessToken, token);
  }

  Future<String?> getKBRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SPrefKey.keyKBRefreshToken);
  }

  Future setKBRefreshToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefKey.keyKBRefreshToken, token);
  }

  // Others

  Future setLocale(String locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("locale", locale);
  }

  Future<String?> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("locale");
  }

  Future<int?> getPermissionLastAsk() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("permissionNotificationLastAsk");
  }

  Future setPermissionLastAsk(int dateTime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("permissionNotificationLastAsk", dateTime);
  }

  Future<int?> getPermissionAskTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("permissionNotificationAskTime");
  }

  Future setPermissionAskTime(int time) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("permissionNotificationAskTime", time);
  }

  dynamic deleteAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final strLocale = prefs.getString('locale');
    await prefs.clear();
    if (strLocale != null) {
      await prefs.setString('locale', strLocale);
    }
  }

  Future saveUserInfo(Map<String, dynamic> map) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefKey.keyUserName, map['username']);
    await prefs.setString(SPrefKey.keyEmail, map['email']);
  }

  Future<Map<String, dynamic>> getLocalUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(SPrefKey.keyUserName);
    final email = prefs.getString(SPrefKey.keyEmail);

    if (username == null || email == null) {
      return {
        'username': 'N/A',
        'email': 'N/A',
      };
    }

    return {
      'username': username,
      'email': email,
    };
  }
}
