import 'package:flutter/material.dart';

import 'package:todo/signUp.dart';
import 'logIn.dart';
import './pageAfterLogIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SignUp(),
      routes: {
        '/LogIn': (context) => LogIn(),
        '/PageAfterLogIn' : (context) => PageAfterLogIn(),
      },
    );
  }
}
