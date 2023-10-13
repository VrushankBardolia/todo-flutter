import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../util/todoModel.dart';

class MyAddTaskDialog extends StatelessWidget {
  const MyAddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final newTask = TextEditingController();
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      title: const Text('Add Task'),
      content: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          hintText: 'Add Task',
        ),
        onChanged: (value){
          newTask.text = value;
        },
        autofocus: true,
        textCapitalization: TextCapitalization.words
      ),
      actions: [
        TextButton(
          onPressed: (){Navigator.pop(context);},
          child: const Text('Cancel')
        ),
        FilledButton(
          onPressed: (){
            final task = ToDoModel(task: newTask.text);
            final box = Hive.box<ToDoModel>('todo');
            box.add(task);
            Navigator.pop(context);
          },
          child: const Text('Add')
        )
      ],
    );
  }
}
