import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/helpers/languageHelper.dart';

class PreferencesHelper {
  static late SharedPreferences _preferences;
  static String preferencesCode = "com.todoApp";
  static String languageCodeKey = "${preferencesCode}languageCodeKey";
  static String languageNameKey = "${preferencesCode}languageNameKey";
  static String tokenKey = "${preferencesCode}tokenKey";
  static String usernameKey = "${preferencesCode}usernameKey";

  PreferencesHelper();

  static String? accessToken = getAccessToken();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static void _setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  static String? _getString(String key, String? expValue) {
    String? value = _preferences.getString(key);
    return value ?? expValue;
  }

  static void setLanguageCode(String code) {
    _setString(languageCodeKey, code);
  }

  static String getLanguageKey() {
    return _getString(languageCodeKey, LanguageHelper.defaultLanguageCode)!;
  }

  static void setLanguage(String language) {
    _setString(languageNameKey, language);
  }

  static String getLanguage() {
    return _getString(languageNameKey, LanguageHelper.defaultLanguageName)!;
  }

  static void setAccessToken(String accessToken) {
    _setString(tokenKey, accessToken);
  }

  static String? getAccessToken() {
    return _getString(tokenKey, null);
  }

  static void setUsername(String username) {
    _setString(usernameKey, username);
  }

  static String? getUsername() {
    return _getString(usernameKey, null);
  }

  static void removeTokenAndUsername() {
    _preferences.remove(tokenKey);
    _preferences.remove(usernameKey);
  }
}
