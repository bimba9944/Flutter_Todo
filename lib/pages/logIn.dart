import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/iconHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

import 'package:todo/helpers/languages.dart';
import 'package:todo/models/enums/inputFieldEnums.dart';
import 'package:todo/widgets/buttonItem.dart';
import 'package:todo/widgets/inputItems.dart';
import 'package:todo/helpers/colorHelper.dart';
import 'package:todo/helpers/preferencesHelper.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();

  Future<bool> loginUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("https://jumborama-tasks.herokuapp.com/auth/signin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',

        },
        body: jsonEncode(
            <String, String>{'username': username, 'password': password}),

      );
      final parsed = jsonDecode(response.body);
      final String token = parsed['accessToken'];
      Map<String, dynamic> data = Jwt.parseJwt(token);
      String user = data['username'];
      print(user);
      PreferencesHelper.setAccessToken(token);
      PreferencesHelper.setUsername(username);

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future<void> validationOnClick() async {
    if (_formKey.currentState!.validate()) {
      bool isGood = await loginUser(usernameController.text, passwordController.text);
      if(!mounted){
        return;
      }
      if(isGood){
        Navigator.pushReplacementNamed(context, '/PageAfterLogIn');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocale.snackBarMessage.getString(context))),
        );
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No such user!')),
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
      appBar: AppBar(
        title: const Text('Todo Manager'),
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.2,
              width: size.width * 1,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorHelper.logInContainer1,
                    ColorHelper.logInContainer2,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    IconHelper.logInContainerIcon,
                    color: ColorHelper.logInContainerIcon,
                    size: 60,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  InputItems(
                    inputIcon: IconHelper.inputIconUser,
                    inputHint: AppLocale.username.getString(context),
                    inputType: InputFieldEnums.usernameInput,
                    obscureText: false,
                    controler: usernameController,
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
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            ButtonItem(
              buttonTxt: AppLocale.logIn.getString(context),
              onPressed: validationOnClick,
            ),
          ],
        ),
      ),
    );
  }
}
