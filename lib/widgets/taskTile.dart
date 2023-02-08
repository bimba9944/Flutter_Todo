import 'package:flutter/material.dart';
import 'package:todo/helpers/appRoutes.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final Color colorOfText;
  final Color colorOfBorder;
  final String id;

  const TaskTile(
      {required this.title,
      required this.subtitle,
      required this.status,
      required this.colorOfText,
      required this.colorOfBorder,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.taskDetails,
          arguments: TaskTile(
              title: title,
              subtitle: subtitle,
              status: status,
              colorOfText: colorOfText,
              colorOfBorder: colorOfBorder,
              id: id)),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromRGBO(249, 210, 157, 1), Color.fromRGBO(255, 216, 203, 1)]),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15, left: 10),
              alignment: Alignment.topLeft,
              child: Text(
                status,
                style: TextStyle(color: colorOfText),
              ),
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.02,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(color: colorOfBorder),
                  margin: const EdgeInsets.only(left: 10, top: 5, bottom: 15),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                    gradient:
                        LinearGradient(colors: [Color.fromRGBO(222, 184, 135, 1), Color.fromRGBO(245, 222, 179, 1)]),
                  ),
                  margin: const EdgeInsets.only(top: 5, right: 15, bottom: 15),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 8, top: 3, bottom: 3),
                    title: Text(title),
                    subtitle: Text(subtitle,maxLines: 1),
                    //isThreeLine: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
