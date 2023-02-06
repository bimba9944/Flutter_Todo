
import 'package:flutter/material.dart';


class ChangeAndDeleteDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final String id;
  final String status;
  final Function func;
  final bool isDelete;

  const ChangeAndDeleteDialog(
      {super.key, required this.title, required this.subtitle, required this.id, required this.status, required this.func, required this.isDelete});

  @override
  State<ChangeAndDeleteDialog> createState() => _ChangeAndDeleteDialogState();
}

class _ChangeAndDeleteDialogState extends State<ChangeAndDeleteDialog> {




  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.subtitle,
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No', style: TextStyle(color: Colors.deepOrangeAccent)),
            ),
            TextButton(
              onPressed:() async => await widget.isDelete == false ? widget.func(widget.id,widget.status) : widget.func(widget.id),
              child: const Text('Yes', style: TextStyle(color: Colors.deepOrangeAccent)),
            ),
          ],
        ),
      ],
    );
  }
}
