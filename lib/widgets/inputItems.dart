import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/colorHelper.dart';
import 'package:todo/helpers/languages.dart';
import 'package:todo/models/enums/inputFieldEnums.dart';

class InputItems extends StatelessWidget {
  final IconData inputIcon;
  final String inputHint;
  final InputFieldEnums inputType;
  final IconData? togleIcon;
  final bool obscureText;
  final Function? onPressed;
  TextEditingController controler = TextEditingController();

  InputItems({
    super.key,
    required this.inputIcon,
    required this.inputHint,
    required this.inputType,
    this.togleIcon,
    required this.obscureText,
    this.onPressed,
    required this.controler
  });

  bool isValidUsername(String value) {
    final usernameRegEx = RegExp(r'[0-9a-zA-Z]{6}');
    return usernameRegEx.hasMatch(value);
  }

  bool isValidPassword(String value) {
    final passwordRegEx = RegExp(r'[0-9a-zA-Z]{8}');
    return passwordRegEx.hasMatch(value);
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            spreadRadius: -50,
            color: ColorHelper.inputShadow,
            blurRadius: 10,
            offset: Offset(10, 20),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: TextFormField(
      obscureText: obscureText,
      controller: controler,
      validator: (value) {
        String? validatorResult;
        if (inputType == InputFieldEnums.usernameInput && !isValidUsername(value!)) {
          validatorResult = AppLocale.snackBarError.getString(context);
        }
        else if (inputType == InputFieldEnums.passwordInput && !isValidPassword(value!)) {
          validatorResult = AppLocale.snackBarError.getString(context);
        }
        return validatorResult;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          inputIcon,
          color: ColorHelper.inputIcon,
        ),
        suffixIcon: IconButton(onPressed: () => onPressed!(), icon: Icon(togleIcon),),

        errorStyle: TextStyle(
          color: Theme
              .of(context)
              .primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        hintText: inputHint,
        hintStyle: TextStyle(fontSize: 16, color: ColorHelper.inputHint),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: ColorHelper.fillColor,
      ),
    ),);
  }

}
