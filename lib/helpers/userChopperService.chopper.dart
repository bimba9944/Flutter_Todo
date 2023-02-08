// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userChopperService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$UserChopperService extends UserChopperService {
  _$UserChopperService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = UserChopperService;

  @override
  Future<Response<dynamic>> postLogin(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/auth/signin');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postSignup(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/auth/signup');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
