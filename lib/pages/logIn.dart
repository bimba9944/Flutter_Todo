import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/iconHelper.dart';

import 'package:todo/helpers/languages.dart';
import 'package:todo/models/enums/inputFieldEnums.dart';
import 'package:todo/widgets/buttonItem.dart';
import 'package:todo/widgets/inputItems.dart';
import 'package:todo/helpers/colorHelper.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();

  void validationOnClick() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/PageAfterLogIn');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
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
                  ),
                  InputItems(
                    inputIcon: IconHelper.inputIconPassword,
                    inputHint: AppLocale.password.getString(context),
                    inputType: InputFieldEnums.passwordInput,
                    obscureText: _obscureText,
                    togleIcon: IconHelper.toglePassword,
                    onPressed: togle,
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
