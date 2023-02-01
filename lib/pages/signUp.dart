import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo/helpers/iconHelper.dart';
import 'package:todo/helpers/languageHelper.dart';
import 'package:todo/helpers/languages.dart';
import 'package:todo/helpers/preferencesHelper.dart';
import 'package:todo/models/enums/inputFieldEnums.dart';
import 'package:todo/models/language.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _initDropdownValue();
    super.initState();
  }

  @override
  void dispose(){
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
    Navigator.pushNamed(context, '/LogIn');
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();


   Future<bool> registerUser(String username, String password) async {
    try {
      if(passwordController.text.contains(repeatPasswordController.text)){
        final response = await http.post(
          Uri.parse("https://jumborama-tasks.herokuapp.com/auth/signup"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{'username': username, 'password': password}),
        );
        return response.statusCode == 201;
      }
      else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> validationOnClick() async {
    if (_formKey.currentState!.validate()) {
        bool isGood = await registerUser(usernameController.text, passwordController.text);
        if(!mounted){
          return;
        }
        if(isGood){
          _changePage();
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User already exist!')),
          );
        }
    }
  }

  bool _obscureText = true;

  void togle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorHelper.signUpContainer1,
                    ColorHelper.signUpContainer2,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    IconHelper.signUpContainerIcon,
                    color: ColorHelper.signUpContainerIcon,
                    size: 60,
                  ),
                  const Text(
                    "Todo Manager",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  InputItems(
                    inputIcon: IconHelper.inputIconUser,
                    inputHint: AppLocale.username.getString(context),
                    inputType: InputFieldEnums.usernameInput,
                    obscureText: false,
                    controler: usernameController
                  ),
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
            ),
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
            DropdownButton<Language>(
              borderRadius: BorderRadius.circular(10),
              underline: Container(color: ColorHelper.underLine, height: 3),
              hint: Text(dropdownValue!.languageName),
              key: UniqueKey(),
              icon: Icon(IconHelper.dropdownIcon),
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
