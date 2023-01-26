import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:todo/signUp.dart';
import 'package:todo/logIn.dart';
import 'package:todo/pageAfterLogIn.dart';
import 'package:todo/languages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    _localization.init(mapLocales: [
      const MapLocale('en', AppLocale.EN),
      const MapLocale('km', AppLocale.KM),
      const MapLocale('ja', AppLocale.JA),
    ],
        initLanguageCode: 'en',
    );
    _localization.onTranslatedLanguage = onTranslatedLanguage;
    super.initState();
  }

  void onTranslatedLanguage(Locale? locale){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
