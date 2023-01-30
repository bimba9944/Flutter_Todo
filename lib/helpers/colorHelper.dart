import 'package:flutter/material.dart';

class ColorHelper{
  static _Container container = _Container();
  static _DropDownButton dropDown = _DropDownButton();
  static _AppBar appBar = _AppBar();
  static _Drawer drawer = _Drawer();
  static _Button button = _Button();
  static _InputField input = _InputField();
}

class _Container{
  Color signUpContainer1 = Colors.deepOrangeAccent;
  Color signUpContainer2 = Colors.orangeAccent;
  Color signUpContainerIcon = Colors.white;
  Color logInContainer1 = Colors.deepOrangeAccent;
  Color logInContainer2 = Colors.orangeAccent;
  Color logInContainerIcon = Colors.white;
}

class _DropDownButton{
  Color underLine = Colors.orangeAccent;
}

class _AppBar{
  Color appBar1 = Colors.deepOrangeAccent;
  Color appBar2 = Colors.orangeAccent;
  Color appBarPageAfterLogIn = Colors.deepOrangeAccent;
  Color appBarIndicatorLine = Colors.white;
}

class _Drawer{
  Color header1 = Colors.deepOrangeAccent;
  Color header2 = Colors.orangeAccent;
}

class _Button{
  Color buttonColor1 = Colors.orangeAccent;
  Color buttonColor2 = Colors.deepOrangeAccent;
  Color buttonText = Colors.white;
}

class _InputField{
  Color inputShadow = Colors.grey;
  Color inputIcon = Colors.grey;
  Color inputHint = Colors.grey;
  Color fillColor = Colors.white;
}