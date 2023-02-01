import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  //final String title;

  //ListTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        title: Text('naslov'),
        subtitle: Text('nesto nesto nesto'),
        isThreeLine: true,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)), side: BorderSide()),
      margin: EdgeInsets.all(20),
    );
  }
}
