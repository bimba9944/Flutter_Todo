// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$TaskService extends TaskService {
  _$TaskService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TaskService;

  @override
  Future<Response<dynamic>> getTasks() {
    final Uri $url = Uri.parse('/tasks');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postTasks(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/tasks');
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
  Future<Response<dynamic>> patchPost(
    Map<String, dynamic> body,
    String id,
  ) {
    final Uri $url = Uri.parse('/tasks/${id}/status');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteTask(String id) {
    final Uri $url = Uri.parse('/tasks/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
