import 'package:chopper/chopper.dart';

part 'userChopperService.chopper.dart';

@ChopperApi(baseUrl: '/auth')
abstract class UserChopperService extends ChopperService{
  @Post(path:'/signin',)
  Future<Response> postLogin(
      @Body() Map<String, dynamic> body,
      );

  @Post(path:'/signup')
  Future<Response> postSignup(
      @Body() Map<String, dynamic> body,
      );

  static UserChopperService create() {
    final client = ChopperClient(
        baseUrl: Uri.parse('https://jumborama-tasks.herokuapp.com'),
        services: [
          _$UserChopperService(),
        ],
        converter: const JsonConverter(),
        );
    return _$UserChopperService(client);
  }
}