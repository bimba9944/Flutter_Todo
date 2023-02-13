import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/languages.dart';

class ChangeAndDeleteDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final String id;
  final String status;
  final Function func;
  final bool isDelete;

  const ChangeAndDeleteDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.id,
    required this.status,
    required this.func,
    required this.isDelete,
  });

  @override
  State<ChangeAndDeleteDialog> createState() => _ChangeAndDeleteDialogState();
}

class _ChangeAndDeleteDialogState extends State<ChangeAndDeleteDialog> {

  Widget _buildActions(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child:  Text(AppLocale.allertButtonNo.getString(context), style: const TextStyle(color: Colors.deepOrangeAccent)),
        ),
        TextButton(
          onPressed: () async =>
          await widget.isDelete == false ? widget.func(widget.id, widget.status) : widget.func(widget.id),
          child: Text(AppLocale.allertButtonYes.getString(context), style: const TextStyle(color: Colors.deepOrangeAccent)),
        ),
      ],
    );

  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.subtitle,
          ),
        ],
      ),
      actions: [_buildActions()],
    );
  }
}
