import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/helpers/languageHelper.dart';

class PreferencesHelper {
  static late SharedPreferences _preferences;
  static String preferencesCode = "com.todoApp";
  static String languageCodeKey = "${preferencesCode}languageCodeKey";
  static String languageNameKey = "${preferencesCode}languageNameKey";

  PreferencesHelper();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static void _setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  static String _getString(String key, String expValue) {
    String? value = _preferences.getString(key);
    return value ?? expValue;
  }

  static void setLanguageCode(String code){
    _setString(languageCodeKey, code);
  }

  static String getLanguageKey(){
    return _getString(languageCodeKey, LanguageHelper.defaultLanguageCode);
  }

  static void setLanguage(String language){
    _setString(languageNameKey, language);
  }

  static String getLanguage(){
    return _getString(languageNameKey, LanguageHelper.defaultLanguageName);
  }






}
