import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/colorHelper.dart';
import 'package:todo/helpers/iconHelper.dart';
import 'package:todo/helpers/languageHelper.dart';
import 'package:todo/helpers/languages.dart';
import 'package:todo/helpers/preferencesHelper.dart';
import 'package:todo/models/language.dart';
import 'package:todo/widgets/headerContainerWidget.dart';
import 'package:todo/widgets/languageTile.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({Key? key}) : super(key: key);

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  bool isSelected = false;

  void _translate(String langCode, String langName) {
    _localization.translate(langCode);
    PreferencesHelper.setLanguageCode(langCode);
    PreferencesHelper.setLanguage(langName);
    isSelected = !isSelected;
  }


  List<Widget> _buildLanguageOptions() {
    List<Widget> options = [];
    for (Language language in LanguageHelper.languages) {
      options.add(
        LanguageTile(
            languageName: language.languageName,
            imagePath: language.imagePath,
            translateFunction: () => _translate(language.languageCode, language.languageName), isSelected: language.
            languageName == PreferencesHelper.getLanguage() ?
              true : false
      ),);
  }
    return
    options;
  }

  Widget _buildHeader() {
    return HeaderContainerWidget(
      colorDarker: ColorHelper.logInContainer1,
      colorLighter: ColorHelper.logInContainer2,
      icon: IconHelper.appIcon,
      iconColor: ColorHelper.logInContainerIcon,
      title: AppLocale.selectLanguagePageTitle.getString(context),
      contHeight: 0.2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [ColorHelper.appBar1, ColorHelper.appBar1]),
          ),
        ),
      ),
      body: ListView(children: [
        _buildHeader(),
        ..._buildLanguageOptions(),
      ]),
    );
  }
}
