import 'package:flutter/material.dart';
import 'package:todo/models/language.dart';

class LanguageHelper{

  static Locale defaultLanguageLocale = const Locale("en");
  static String defaultLanguageCode = 'en';
  static String defaultLanguageName = 'English';

  static List<Language> languages = [
    Language(languageName: "English", languageCode: "en", imagePath: ""),
    Language(languageName: "Chinese", languageCode: "km", imagePath: ""),
    Language(languageName: "Japanese", languageCode: "ja", imagePath: ""),
  ];
}