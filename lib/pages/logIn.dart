import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/languages.dart';

import 'package:todo/widgets/buttonItem.dart';
import 'package:todo/widgets/inputItems.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Manager'),
        centerTitle: true,
        //backgroundColor: Colors.deepOrange,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.deepOrangeAccent, Colors.deepOrangeAccent]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepOrangeAccent,
                    Colors.orangeAccent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.ac_unit,
                    color: Colors.white,
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
