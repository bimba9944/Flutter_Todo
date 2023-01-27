import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:todo/helpers/languageHelper.dart';
import 'package:todo/helpers/languages.dart';
import 'package:todo/helpers/preferencesHelper.dart';
import 'package:todo/models/language.dart';
import 'package:todo/widgets/inputItems.dart';
import 'package:todo/widgets/buttonItem.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<Language> listOfLanguages = LanguageHelper.languages;
  Language? dropdownValue;
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    _initDropdownValue();
    super.initState();
  }

  void _initDropdownValue() {
    String languageName = PreferencesHelper.getLanguage();
    String languageCode = PreferencesHelper.getLanguageKey();
    dropdownValue = Language(languageName: languageName, languageCode: languageCode, imagePath: '');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.3,
              width: size.width * 1,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepOrangeAccent,
                    Colors.orangeAccent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.ac_unit,
                    color: Colors.white,
                    size: 60,
                  ),
                  Text(
                    "Todo Manager",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            InputItems(
              Icons.mail,
              AppLocale.email.getString(context),
            ),
            InputItems(Icons.key, AppLocale.password.getString(context)),
            InputItems(Icons.key, AppLocale.repeatPassword.getString(context)),
            const SizedBox(height: 30),
            ButtonItem(AppLocale.register.getString(context)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(AppLocale.alreadyAMember.getString(context)),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/LogIn');
                  },
                  child: Text(AppLocale.logIn.getString(context)),
                ),
              ],
            ),
            DropdownButton<Language>(
              borderRadius: BorderRadius.circular(10),
              underline: Container(color: Colors.orangeAccent, height: 3),
              hint: Text(dropdownValue!.languageName),
              key: UniqueKey(),
              icon: const Icon(Icons.language),
              items: listOfLanguages.map<DropdownMenuItem<Language>>((Language language) {
                return DropdownMenuItem(value: language, child: Text(language.languageName));
              }).toList(),
              onChanged: (Language? language) {
                String languageCode = PreferencesHelper.getLanguageKey();
                String languageName = PreferencesHelper.getLanguage();
                if (language != null) {
                  dropdownValue = language;
                  languageCode = language.languageCode;
                  languageName = language.languageName;
                }

                _localization.translate(languageCode);
                PreferencesHelper.setLanguageCode(languageCode);
                PreferencesHelper.setLanguage(languageName);
              },
            ),
          ],
        ),
      ),
    );
  }
}