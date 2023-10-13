import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/components/myDeleteDialog.dart';
import 'package:todo/util/todoModel.dart';

// class MyToDoTile extends StatelessWidget {
//   final ToDoModel todo;
//   final int index;
//   final Function(int) onDelete;
//
//   const MyToDoTile({
//     super.key,
//     required this.todo,
//     required this.index,
//     required this.onDelete
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).colorScheme;
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListTile(
//         tileColor: theme.secondaryContainer,
//         title: Text(todo.task,
//           style: TextStyle(
//             decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none),
//         ),
//         leading: Checkbox(
//           value: todo.isDone,
//           onChanged: (value) {
//             setState(() {
//               // Toggle the task completion status
//               todo.isDone = value!;
//               todo.save(); // Save the updated task to Hive
//             });
//           },
//         ),
//         // leading: SizedBox(
//         //   height: 24,
//         //   width: 24,
//         //   child: Center(
//         //     child: Icon(todo.isDone ? Icons.check_box : Icons.check_box_outline_blank_outlined))
//         // ),
//         onTap: (){
//           final newTodo = ToDoModel(
//               task: todo.task,
//               isDone: todo.isDone);
//           Hive.box<ToDoModel>('todo').putAt(index, newTodo);
//         },
//         trailing: IconButton(
//             onPressed: (){
//               onDelete(index);
//             },
//             icon: Icon(Icons.delete)
//         ),
//       )
//     );
//   }
// }

class MyToDoTile extends StatefulWidget {
  final ToDoModel todo;
  final int index;
  final Function(int) onDelete;

  const MyToDoTile({
    super.key,
    required this.todo,
    required this.index,
    required this.onDelete
  });

  @override
  State<MyToDoTile> createState() => _MyToDoTileState();
}

class _MyToDoTileState extends State<MyToDoTile> {

  _delete(){
    widget.onDelete(widget.index);
  }

  onDelete(){
    showDialog(
      context: context,
      builder: (context){
        return MyDeleteDialog(
          delete: _delete
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 8,right: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textColor: theme.onSecondaryContainer,
          tileColor: theme.secondaryContainer,
          title: Text(widget.todo.task,
            style: TextStyle(
                decoration: widget.todo.isDone ? TextDecoration.lineThrough : TextDecoration.none),
          ),
          leading: Checkbox(
            value: widget.todo.isDone,
            onChanged: (value) {
              setState(() {
                widget.todo.isDone = value!;
                widget.todo.save();
              });
            },
          ),
          onTap: (){
            final newTodo = ToDoModel(
                task: widget.todo.task,
                isDone: widget.todo.isDone);
            Hive.box<ToDoModel>('todo').putAt(widget.index, newTodo);
          },
          trailing: IconButton(
            icon: Icon(Icons.delete, color: theme.error),
            onPressed: onDelete
          ),
        )
    );
  }
}

