import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/appRoutes.dart';
import 'package:todo/helpers/languages.dart';
import 'package:todo/helpers/notificationService.dart';
import 'package:todo/models/enums/statusEnum.dart';

import 'package:todo/services/taskService.dart';
import 'package:todo/widgets/changeAndDeleteDialog.dart';
import 'package:todo/widgets/taskTile.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  void _successfullOperation(String message) {
    if (mounted) {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, AppRoutes.homePage);
      NotificationService().showNotification(title: 'Notification', body: message);
    }
  }

  Future<bool> changeStatus(String id, String status) async {
    try {
      if (status == StatusEnum.OPEN.name) {
        status = StatusEnum.DONE.name;
      } else {
        status = StatusEnum.OPEN.name;
      }
      TaskService service = TaskService.create();
      final response = await service.patchPost({"status": status}, id);
      _successfullOperation('Succesfully changed status');
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTask(String id) async {
    try {
      TaskService service = TaskService.create();
      final response = await service.deleteTask(id);
      _successfullOperation('Task deleted successfully');
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<String?> _showDialog(){
    final args = ModalRoute.of(context)!.settings.arguments as TaskTile;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => ChangeAndDeleteDialog(
        title: AppLocale.allertConfirmChangeTitle.getString(context),
        subtitle: AppLocale.allertConfirmChange.getString(context),
        id: args.id,
        status: args.status,
        func: changeStatus,
        isDelete: false,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as TaskTile;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.taskDetailsTitleAppbar.getString(context)),
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
                  onPressed: () => _showDialog(),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Change status', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => ChangeAndDeleteDialog(
                      title: AppLocale.allertConfirmDeleteTitle.getString(context),
                      subtitle: AppLocale.allertConfirmDelete.getString(context),
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
