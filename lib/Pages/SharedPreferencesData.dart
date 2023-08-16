import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesData {
  static late SharedPreferences _sharedPreferences;
  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

    static const _keyEmail = 'email';


    static Future setUsername(String email) async =>
    await _sharedPreferences.setString(_keyEmail, email);

    static String? getUsername() => _sharedPreferences.getString(_keyEmail);

}