import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/components/myAddTaskDialog.dart';
import 'package:todo/util/todoModel.dart';

import '../components/myToDoTile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todo=Hive.box<ToDoModel>('todo');

  void _deleteTodo(int index){
    _todo.deleteAt(index);
  }
  
  addTodo(){
    return showDialog(
        context: context,
        builder: (context){
          return MyAddTaskDialog();
        }
    );
  }

  taskList(Box<ToDoModel> box){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
      child: ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: box.length,
          itemBuilder: (context,index){
            final todo = box.getAt(index)!;
            return MyToDoTile(
                todo: todo,
                onDelete:_deleteTodo,
                index: index
            );
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.primaryContainer,
        centerTitle: true,
        title: Text('TO DO',
          style: TextStyle(
            color: theme.onPrimaryContainer,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _todo.listenable(),
        builder: (context, Box<ToDoModel> box,_) {
          if (box.isEmpty) {
            return Center(
              child: Text('No Tasks Are Available 🙃\nWhy Don\'t You Add? 👇',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 16
                ),
              )
            );
          }
          return taskList(box);
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addTodo,
        label: const Text('Add Task'),
        icon: const Icon(Icons.add_rounded),
        elevation: 0,
      )
    );
  }
}
