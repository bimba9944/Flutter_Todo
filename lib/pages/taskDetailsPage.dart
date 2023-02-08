import 'package:flutter/material.dart';
import 'package:todo/helpers/appRoutes.dart';

import 'package:todo/helpers/taskService.dart';
import 'package:todo/widgets/changeAndDeleteDialog.dart';
import 'package:todo/widgets/taskTile.dart';


class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  Future<bool> changeStatus( String id,String status) async {
    try {
      if (status == 'OPEN') {
        status = 'DONE';
      } else {
        status = 'OPEN';
      }
      TaskService service = TaskService.create();
      final response = await service.patchPost({"status": status}, id);
      if (mounted) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, AppRoutes.homePage);
      }
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTask(String id) async {
    try {
      TaskService service = TaskService.create();
      final response = await service.deleteTask(id);
      if (mounted) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, AppRoutes.homePage);
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
                    builder: (BuildContext context) => ChangeAndDeleteDialog(
                      title: 'Mark as done?',
                      subtitle: 'You are about to change status of task. Are you sure you want to continue?',
                      id: args.id,
                      status: args.status,
                      func: changeStatus,
                      isDelete: false,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Change status', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => ChangeAndDeleteDialog(
                      title: 'Delete task?',
                      subtitle: 'You are about to delete this task. Are you sure you want to continue?',
                      id: args.id,
                      status: args.status,
                      func: deleteTask,
                      isDelete: true,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete task', style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
