import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/helpers/preferencesHelper.dart';
import 'package:todo/widgets/changeAndDeleteDialog.dart';
import 'package:todo/widgets/taskTile.dart';
import 'package:http/http.dart' as http;

class TaskDetails extends StatefulWidget {

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  Future<bool> changeStatus(String id, String status) async {
    String? token = PreferencesHelper.getAccessToken();
    try {
      if (status == 'OPEN') {
        status = 'DONE';
      } else {
        status = 'OPEN';
      }
      final response = await http.patch(
        Uri.parse("https://jumborama-tasks.herokuapp.com/tasks/$id/status"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{'status': status}),
      );
      if (mounted) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/HomePage');
      }
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTask(String id) async {
    String? token = PreferencesHelper.getAccessToken();
    try {
      final response = await http.delete(
        Uri.parse("https://jumborama-tasks.herokuapp.com/tasks/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (mounted) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/HomePage');
      }
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as TaskTile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task details'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(height: 50, width: 10, color: args.colorOfBorder),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    args.title,
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Text(
              args.subtitle,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>  ChangeAndDeleteDialog(
                      title: 'Mark as done?',
                      subtitle: 'You are about to change status of task. Are you sure you want to continue?',
                      id: args.id,
                      status: args.status,
                      func: changeStatus,
                      isDelete: false,
                    ),
                  ),
                  child: Text('Change status', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>  ChangeAndDeleteDialog(
                      title: 'Delete task?',
                      subtitle: 'You are about to delete this task. Are you sure you want to continue?',
                      id: args.id,
                      status: args.status,
                      func: deleteTask,
                      isDelete: true,
                    ),
                  ),
                  child: Text('Delete task', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
