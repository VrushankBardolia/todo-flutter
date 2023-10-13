import 'package:flutter/material.dart';

class MyDeleteDialog extends StatelessWidget {
  final Function() delete;

  const MyDeleteDialog({super.key, required this.delete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Task?'),
      content: Text('This task will be deleted permanently'),
      actions: [
        TextButton(
          onPressed: (){Navigator.pop(context);},
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: (){
            delete();
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        )
      ],
    );
  }
}
