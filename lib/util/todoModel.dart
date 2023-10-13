import 'package:hive/hive.dart';
part 'todoModel.g.dart';

@HiveType(typeId: 0)
class ToDoModel extends HiveObject{

  @HiveField(0)
  late String task;

  @HiveField(1)
  late bool isDone;

  ToDoModel({required this.task, this.isDone=false});
}