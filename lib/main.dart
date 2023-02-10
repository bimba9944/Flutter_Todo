import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/notificationService.dart';


import 'package:todo/helpers/preferencesHelper.dart';
import 'package:todo/pages/homePage.dart';
import 'package:todo/pages/selectLanguagePage.dart';
import 'package:todo/pages/signUp.dart';
import 'package:todo/pages/logIn.dart';
import 'package:todo/pages/splashPage.dart';
import 'package:todo/pages/taskDetailsPage.dart';

import 'helpers/appRoutes.dart';
import 'helpers/languageHelper.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
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
  late String _languageCode;
  @override
  void initState() {
     _languageCode = PreferencesHelper.getLanguageKey();
    _localization.init(mapLocales: LanguageHelper.mapOfLanguages,
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
      locale: _locale ,
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: _localization.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: {
        AppRoutes.defaultRoute: (context) => SplashPage(),
        AppRoutes.signUp : (context) => SignUp(),
        AppRoutes.logIn: (context) => LogIn(),
        AppRoutes.homePage: (context) => HomePage(),
        AppRoutes.taskDetails: (context) => TaskDetails(),
        AppRoutes.languagePage: (context) => SelectLanguagePage()
      },
    );
  }
}
