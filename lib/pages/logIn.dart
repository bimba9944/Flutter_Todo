import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/appRoutes.dart';
import 'package:todo/helpers/iconHelper.dart';


import 'package:todo/helpers/languages.dart';
import 'package:todo/helpers/snackBarHelper.dart';
import 'package:todo/services/userService.dart';
import 'package:todo/models/enums/inputFieldEnums.dart';
import 'package:todo/widgets/buttonItem.dart';
import 'package:todo/widgets/headerContainerWidget.dart';
import 'package:todo/widgets/inputItems.dart';
import 'package:todo/helpers/colorHelper.dart';


class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  Future<void> _validationOnClick() async {
    if (_formKey.currentState!.validate()) {
      bool isGood = await UserService.loginUser(usernameController.text, passwordController.text);
      if (!mounted) {
        return;
      }
      if (isGood) {
        Navigator.pushReplacementNamed(context, AppRoutes.homePage);
        SnackBarHelper.buildSnackBar(AppLocale.snackBarMessage.getString(context),context);
      } else {
        SnackBarHelper.buildSnackBar(AppLocale.snackBarError.getString(context),context);
      }
    }
  }

  void _togle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title:  Text(AppLocale.loginTitleAppbar.getString(context)),
      centerTitle: true,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center, end: Alignment.bottomCenter, colors: [ColorHelper.appBar1, ColorHelper.appBar1]),
        ),
      ),
    );
  }

  Widget _buildform() {
    return Form(
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
            onPressed: _togle,
            controler: passwordController,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainerWidget(
              colorDarker: ColorHelper.logInContainer1,
              colorLighter: ColorHelper.logInContainer2,
              icon: IconHelper.appIcon,
              iconColor: ColorHelper.logInContainerIcon,
              title: '',
              contHeight: 0.2,
            ),
            const SizedBox(
              height: 40,
            ),
            _buildform(),
            const SizedBox(
              height: 60,
            ),
            ButtonItem(
              buttonTxt: AppLocale.logIn.getString(context),
              onPressed: _validationOnClick,
            ),
          ],
        ),
      ),
    );
  }
}
