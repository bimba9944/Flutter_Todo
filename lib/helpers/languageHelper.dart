import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/i18n/english.dart';
import 'package:todo/helpers/i18n/japanese.dart';
import 'package:todo/models/language.dart';

import 'package:todo/helpers/i18n/chinese.dart';

class LanguageHelper{

  static Locale defaultLanguageLocale = const Locale("en");
  static String defaultLanguageCode = 'en';
  static String defaultLanguageName = 'English';

  static List<Language> languages = [
    Language(languageName: "English", languageCode: "en", imagePath: "assets/images/english.png"),
    Language(languageName: "中国人", languageCode: "km", imagePath: "assets/images/chinese.png"),
    Language(languageName: "日本", languageCode: "ja", imagePath: "assets/images/japanese.png"),
  ];

  static List<MapLocale> mapOfLanguages = [
  const MapLocale('en', English.EN),
  const MapLocale('km', Chinese.KM),
  const MapLocale('ja', Japanese.JA),
  ];

}