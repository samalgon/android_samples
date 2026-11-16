import 'package:floor/floor.dart';


@entity //this is an entity
class ToDoItem {
  @PrimaryKey(autoGenerate: true)//this is a primary key
  final int? id;
  final String todoItem;

  ToDoItem({this.id, required this.todoItem}) {
  }


  @override
  toString() {
    return "$id:$todoItem";
  }
}
