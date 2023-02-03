import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final Color colorOfText;

  TaskTile({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.colorOfText
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)), side: BorderSide()),
      margin: const EdgeInsets.all(5),
      child: ListTile(

        title: Text(title),
        subtitle: Text(subtitle),
        isThreeLine: true,
        trailing: Text(status, style: TextStyle(color: colorOfText),),
      ),
    );
  }
}
