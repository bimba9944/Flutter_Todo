import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/colorHelper.dart';
import 'package:todo/helpers/languages.dart';
import 'package:todo/helpers/regExpHelper.dart';
import 'package:todo/models/enums/inputFieldEnums.dart';

class InputItems extends StatefulWidget {
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

  @override
  State<InputItems> createState() => _InputItemsState();
}

class _InputItemsState extends State<InputItems> {
  bool isValidUsername(String value) {
    return RegExpHelper.usernameRegEx.hasMatch(value);
  }

  bool isValidPassword(String value) {
    return RegExpHelper.passwordRegEx.hasMatch(value);
  }

  String? validator(value){
    String? validatorResult;
    if (widget.inputType == InputFieldEnums.usernameInput && !isValidUsername(value!)) {
      validatorResult = AppLocale.snackBarError.getString(context);
    }
    else if (widget.inputType == InputFieldEnums.passwordInput && !isValidPassword(value!)) {
      validatorResult = AppLocale.snackBarError.getString(context);
    }
    return validatorResult;
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
      obscureText: widget.obscureText,
      controller: widget.controler,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.inputIcon,
          color: ColorHelper.inputIcon,
        ),
        suffixIcon: IconButton(onPressed: () => widget.onPressed!(), icon: Icon(widget.togleIcon),),

        errorStyle: TextStyle(
          color: Theme
              .of(context)
              .primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        hintText: widget.inputHint,
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
