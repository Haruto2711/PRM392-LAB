import 'package:shared_preferences/shared_preferences.dart';

class SessionService {

  static const String tokenKey =
      'access_token';

  Future<void> saveToken(
      String token) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      tokenKey,
      token,
    );
  }

  Future<String?> getToken() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      tokenKey,
    );
  }

  Future<void> logout() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.remove(
      tokenKey,
    );
  }
}