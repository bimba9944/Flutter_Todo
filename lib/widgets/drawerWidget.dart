import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/appRoutes.dart';
import 'package:todo/helpers/colorHelper.dart';
import 'package:todo/helpers/iconHelper.dart';
import 'package:todo/helpers/languageHelper.dart';
import 'package:todo/helpers/languages.dart';
import 'package:todo/helpers/preferencesHelper.dart';
import 'package:todo/models/language.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String? username = PreferencesHelper.getUsername();
  final FlutterLocalization _localization = FlutterLocalization.instance;

  void _translate(String langCode, String langName) {
    _localization.translate(langCode);
    PreferencesHelper.setLanguageCode(langCode);
    PreferencesHelper.setLanguage(langName);
    Navigator.pop(context);
  }

  void _changePage() {
    PreferencesHelper.removeTokenAndUsername();
    Navigator.pushReplacementNamed(context, AppRoutes.logIn);
  }

  List<Widget> _buildLanguageOptions() {
    List<Widget> options = [];
    for (Language language in LanguageHelper.languages) {
      options.add(
        TextButton(
          onPressed: () => _translate(language.languageCode, language.languageName),
          child: Text(language.languageName, style: const TextStyle(fontSize: 25)),
        ),
      );
    }
    return options;
  }

  Future _buildModalSheet() {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: size.height * 0.4,
          child: Column(
            children: _buildLanguageOptions(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ColorHelper.header1, ColorHelper.header2],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Todo Manager',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text(
                  'Username: $username',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(IconHelper.changeLanguage),
            title: Text(AppLocale.changeLanguage.getString(context)),
            onTap: _buildModalSheet,
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(IconHelper.changeTheme),
            title: Text(
              AppLocale.changeTheme.getString(context),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(IconHelper.logOut),
            onTap: _changePage,
            title: Text(AppLocale.logOut.getString(context)),
          ),
        ],
      ),
    );
  }
}
