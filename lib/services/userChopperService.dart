import 'package:chopper/chopper.dart';
import 'package:todo/helpers/appUrls.dart';

part 'userChopperService.chopper.dart';

@ChopperApi(baseUrl: AppUrls.userService)
abstract class UserChopperService extends ChopperService{
  @Post(path: AppUrls.signin,)
  Future<Response> postLogin(
      @Body() Map<String, dynamic> body,
      );

  @Post(path: AppUrls.signup)
  Future<Response> postRegister(
      @Body() Map<String, dynamic> body,
      );

  static UserChopperService create() {
    final client = ChopperClient(
        baseUrl: Uri.parse(AppUrls.defaultUrl),
        services: [
          _$UserChopperService(),
        ],
        converter: const JsonConverter(),
        );
    return _$UserChopperService(client);
  }
}