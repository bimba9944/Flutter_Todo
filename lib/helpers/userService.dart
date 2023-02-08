import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:todo/helpers/preferencesHelper.dart';
import 'package:todo/helpers/userChopperService.dart';

class UserService {
  late TextEditingController? passwordController;
  late TextEditingController? repeatPasswordController;

  UserService(this.passwordController, this.repeatPasswordController);

  Future<bool> loginUser(String username, String password) async {
    try {
      UserChopperService service = UserChopperService.create();
      final response = await service.postLogin({"username": username, "password": password});
      final parsed = jsonDecode(response.bodyString);
      final String token = parsed['accessToken'];
      Map<String, dynamic> data = Jwt.parseJwt(token);
      String user = data['username'];
      PreferencesHelper.setAccessToken(token);
      PreferencesHelper.setUsername(user);
      print(token);

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerUser(String username, String password) async {
    bool result;
    try {
      if (passwordController!.text.contains(repeatPasswordController!.text)) {
        UserChopperService service = UserChopperService.create();
        final response = await service.postSignup({"username": username, "password": password},);
        result = response.statusCode == 201;
      } else {
        result = false;
      }
    } catch (e) {
      result = false;
    }
    return result;
  }
}
