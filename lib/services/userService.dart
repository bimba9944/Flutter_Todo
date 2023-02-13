import 'dart:convert';


import 'package:jwt_decode/jwt_decode.dart';
import 'package:todo/helpers/preferencesHelper.dart';
import 'package:todo/services/userChopperService.dart';

class UserService {


  static void _saveToPreferences(String accessToken, String username){
    PreferencesHelper.setAccessToken(accessToken);
    PreferencesHelper.setUsername(username);
  }

  static Future<bool> loginUser(String username, String password) async {
    try {
      final response = await UserChopperService.create().postLogin({"username": username, "password": password});
      final parsed = jsonDecode(response.bodyString);
      final String token = parsed['accessToken'];
      Map<String, dynamic> data = Jwt.parseJwt(token);
      String user = data['username'];
      _saveToPreferences(token,user);

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> registerUser(String username, String password) async {
    bool result;
    try {
        UserChopperService service = UserChopperService.create();
        final response = await service.postRegister({"username": username, "password": password},);
        result = response.statusCode == 201;
    } catch (e) {
      result = false;
    }
    return result;
  }
}
