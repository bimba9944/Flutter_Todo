import 'package:chopper/chopper.dart';
import 'package:todo/helpers/preferencesHelper.dart';

part 'taskService.chopper.dart';

@ChopperApi(baseUrl: '/tasks')
abstract class TaskService extends ChopperService {
  @Get()
  Future<Response> getTasks();

  @Post()
  Future<Response> postTasks(
    @Body() Map<String, dynamic> body,
  );

  @Patch(
    path: '/{id}/status',
  )
  Future<Response> patchPost(@Body() Map<String, dynamic> body, @Path('id') String id);

  @Delete(
    path: '/{id}',
  )
  Future<Response> deleteTask(@Path('id') String id);

  static TaskService create() {
    final client = ChopperClient(
        baseUrl: Uri.parse('https://jumborama-tasks.herokuapp.com'),
        services: [
          _$TaskService(),
        ],
        converter: const JsonConverter(),
        interceptors: [
          (Request request) async {
           return applyHeader(request, 'Authorization','Bearer ${PreferencesHelper.getAccessToken()}');
          }
        ]);
    return _$TaskService(client);
  }
}
