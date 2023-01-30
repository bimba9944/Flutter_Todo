import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:todo/helpers/preferencesHelper.dart';
import 'package:todo/pages/signUp.dart';
import 'package:todo/pages/logIn.dart';
import 'package:todo/pages/pageAfterLogIn.dart';
import 'package:todo/helpers/languages.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesHelper.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  Locale? _locale;
  String _languageCode = 'en';
  @override
  void initState() {
     _languageCode = PreferencesHelper.getLanguageKey();
    _localization.init(mapLocales: [
      const MapLocale('en', AppLocale.EN),
      const MapLocale('km', AppLocale.KM),
      const MapLocale('ja', AppLocale.JA),
    ],
        initLanguageCode: _languageCode,
    );
    _localization.onTranslatedLanguage = onTranslatedLanguage;
    super.initState();
  }

  void onTranslatedLanguage(Locale? locale){
    if(locale != null){
    PreferencesHelper.setLanguageCode(locale.languageCode);
    }

    _locale = locale;
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale ?? const Locale('en'),
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: _localization.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SignUp(),
      routes: {
        '/LogIn': (context) => LogIn(),
        '/PageAfterLogIn': (context) => PageAfterLogIn(),
      },
    );
  }
}
