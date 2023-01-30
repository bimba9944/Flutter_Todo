import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:todo/helpers/languages.dart';
import 'package:todo/widgets/buttonItem.dart';
import 'package:todo/widgets/inputItems.dart';
import 'package:todo/helpers/colorHelper.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
                colors: [ColorHelper.appBar.appBar1, ColorHelper.appBar.appBar1]),
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
                    ColorHelper.container.logInContainer1,
                    ColorHelper.container.logInContainer2,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.ac_unit,
                    color: ColorHelper.container.logInContainerIcon,
                    size: 60,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InputItems(Icons.perm_identity, AppLocale.userOrEmail.getString(context)),
            InputItems(Icons.key, AppLocale.password.getString(context)),
            const SizedBox(
              height: 60,
            ),
            ButtonItem(AppLocale.logIn.getString(context)),
          ],
        ),
      ),
    );
  }
}
