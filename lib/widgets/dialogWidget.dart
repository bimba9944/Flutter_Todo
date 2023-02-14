import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/languages.dart';
import 'package:todo/helpers/notificationService.dart';

import 'package:todo/services/taskService.dart';

class DialogWidget extends StatefulWidget {
  final Function displayTasks;

  const DialogWidget(this.displayTasks, {super.key});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Widget _buildSingleInputField(String hintTxt, int numLines, TextEditingController controler) {
    return TextFormField(
      controller: controler,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        hintText: hintTxt,
      ),
      maxLines: numLines,
    );
  }

  Future<bool> postTask(String title, String description) async {
    if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
      try {
        TaskService service = TaskService.create();
        final response = await service.postTasks({"title": titleController.text,"description":descriptionController.text});
        widget.displayTasks();
        if (mounted) {
          Navigator.pop(context);
          NotificationService().showNotification(title: 'Notification',body: 'Task added successfully');
        }
        return response.statusCode == 201;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Widget _buildActions(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () => postTask(titleController.text, descriptionController.text),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: Text(AppLocale.dialogAddTask.getString(context), style: const TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: Text(AppLocale.dialogCancel.getString(context), style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSingleInputField(AppLocale.dialogTitle.getString(context), 1, titleController),
            const SizedBox(
              height: 10,
            ),
            _buildSingleInputField(AppLocale.dialogDescription.getString(context), 6, descriptionController),
          ],
        ),
      ),
      actions: [_buildActions()],
    );
  }
}
