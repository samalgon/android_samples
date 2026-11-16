import 'dart:async';
import 'todo_item.dart';
import 'todo_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [ToDoItem])
abstract class ToDoDatabase extends FloorDatabase {
  ToDoDAO get toDoDAO;
}
