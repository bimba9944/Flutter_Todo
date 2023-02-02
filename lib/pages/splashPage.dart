import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:todo/helpers/preferencesHelper.dart';

class SplashPage extends StatefulWidget {


  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Timer(Duration(milliseconds: 5000),() => changePage());
    super.initState();
  }

  void changePage(){
    String? token = PreferencesHelper.getAccessToken();
    if(token == null || Jwt.isExpired(token)){
      Navigator.pushReplacementNamed(context, '/SignUp');
    }
    else{
      Navigator.pushReplacementNamed(context, '/PageAfterLogIn');
    }
    }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: const Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        body: Center(child: Text('Todo Manager', style: TextStyle(fontSize: 30,color: Colors.white))),
      ),
    );
  }
}
