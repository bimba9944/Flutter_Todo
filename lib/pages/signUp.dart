import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:todo/helpers/appRoutes.dart';


import 'package:todo/helpers/iconHelper.dart';
import 'package:todo/helpers/languageHelper.dart';
import 'package:todo/helpers/languages.dart';
import 'package:todo/helpers/preferencesHelper.dart';
import 'package:todo/helpers/userService.dart';
import 'package:todo/models/enums/inputFieldEnums.dart';
import 'package:todo/models/language.dart';
import 'package:todo/widgets/headerContainerWidget.dart';
import 'package:todo/widgets/inputItems.dart';
import 'package:todo/widgets/buttonItem.dart';
import 'package:todo/helpers/colorHelper.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<Language> listOfLanguages = LanguageHelper.languages;
  Language? dropdownValue;
  final FlutterLocalization _localization = FlutterLocalization.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  @override
  void initState() {
    _initDropdownValue();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  void _initDropdownValue() {
    String languageName = PreferencesHelper.getLanguage();
    String languageCode = PreferencesHelper.getLanguageKey();
    dropdownValue = Language(languageName: languageName, languageCode: languageCode, imagePath: '');
    setState(() {});
  }

  void _changePage() {
    Navigator.pushNamed(context, AppRoutes.logIn);
  }




  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> callingSnackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> validationOnClick() async {
    if (_formKey.currentState!.validate()) {
      bool isGood = await UserService(passwordController,repeatPasswordController).registerUser(usernameController.text, passwordController.text);
      if (!mounted) {
        return;
      }
      if (isGood) {
        _changePage();
      } else {
        callingSnackBar(AppLocale.snackBarError);
      }
    }
  }

  void togle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildForm(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputItems(
              inputIcon: IconHelper.inputIconUser,
              inputHint: AppLocale.username.getString(context),
              inputType: InputFieldEnums.usernameInput,
              obscureText: false,
              controler: usernameController),
          InputItems(
            inputIcon: IconHelper.inputIconPassword,
            inputHint: AppLocale.password.getString(context),
            inputType: InputFieldEnums.passwordInput,
            obscureText: _obscureText,
            togleIcon: IconHelper.toglePassword,
            onPressed: togle,
            controler: passwordController,
          ),
          InputItems(
            inputIcon: IconHelper.inputIconPassword,
            inputHint: AppLocale.repeatPassword.getString(context),
            inputType: InputFieldEnums.passwordInput,
            obscureText: _obscureText,
            togleIcon: IconHelper.toglePassword,
            onPressed: togle,
            controler: repeatPasswordController,
          ),
        ],
      ),
    );
  }

  void _dropdownOnchanged(Language? language){
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
  }




  Widget _buildDropdownButton(){
    return DropdownButton<Language>(
      borderRadius: BorderRadius.circular(10),
      underline: Container(color: ColorHelper.underLine, height: 3),
      hint: Text(dropdownValue!.languageName),
      key: UniqueKey(),
      icon: Icon(IconHelper.dropdownIcon),
      items: listOfLanguages.map<DropdownMenuItem<Language>>((Language language) {
        return DropdownMenuItem(value: language, child: Text(language.languageName));
      }).toList(),
      onChanged: _dropdownOnchanged,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainerWidget(
                color1: ColorHelper.signUpContainer1,
                color2: ColorHelper.signUpContainer2,
                icon: IconHelper.appIcon,
                iconColor: ColorHelper.signUpContainerIcon,
                title: 'Todo Manager',),
            const SizedBox(height: 30),
            _buildForm(),
            const SizedBox(height: 30),
            ButtonItem(
              buttonTxt: AppLocale.register.getString(context),
              onPressed: validationOnClick,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(AppLocale.alreadyAMember.getString(context)),
                TextButton(
                  onPressed: _changePage,
                  child: Text(AppLocale.logIn.getString(context)),
                ),
              ],
            ),
            _buildDropdownButton(),
          ],
        ),
      ),
    );
  }
}
