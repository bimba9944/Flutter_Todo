import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo/helpers/appRoutes.dart';
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

  Future<void> permissionHandler() async {
    PermissionStatus status = await Permission.notification.status;
    if(status.isDenied){
      status = await Permission.notification.request();
    }
    if(await Permission.notification.isRestricted){

    }
    if(await Permission.notification.request().isGranted){

    }
  }

  void _navigateToRegister(){
    Navigator.pushReplacementNamed(context, AppRoutes.register);
  }

  void _navigateToHome(){
    Navigator.pushReplacementNamed(context, AppRoutes.homePage);
  }

  void changePage(){
    String? token = PreferencesHelper.getAccessToken();
    permissionHandler();
    if(token == null || Jwt.isExpired(token)){
      _navigateToRegister();
    }
    else{
      _navigateToHome();
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
