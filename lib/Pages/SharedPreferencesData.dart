import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesData {
  static late SharedPreferences _sharedPreferences;
  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
}
}