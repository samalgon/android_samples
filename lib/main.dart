import 'package:flutter/material.dart';
import 'todo_dao.dart';
import 'todo_item.dart';
import 'database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Android Samples',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            secondary: Colors.green,
            primary: Colors.red),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Using a Database'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDoItem> todoList = <ToDoItem>[];
  late TextEditingController _inputController;
  late ToDoDAO taskDAO;

  @override //same as in java
  void initState() {
    super.initState(); //call the parent initState()
    _inputController = TextEditingController();

    $FloorToDoDatabase
        .databaseBuilder('mytodo_database.db')
        .build()
        .then((database) async { //Note the use of async here
      taskDAO = database.toDoDAO;
      //get Items from database:
      var it = await taskDAO.getAllItems();
      setState(() {
        todoList = it;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _inputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title)),
        body: listPage());
  }

  Future<void> addTask() async {
    if (_inputController.text.isNotEmpty) {
      // Use this if Primary Key is not auto-generated
      var newItem = ToDoItem(todoItem: _inputController.text);
      await taskDAO.insertItem(newItem);
      setState(() {
        todoList.add(newItem);
        _inputController.clear();
      });
    } else {
      var snackBar = SnackBar(content: Text('Input field is required'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void deleteAll() async {
    if (todoList.isNotEmpty) {
      await taskDAO.deleteAllItems();
      setState(() {
        todoList.clear();
      });
    }
  }
  Widget listPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 20),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, rowNum) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded (
                      flex: 3,
                      child: Container (
                        color: rowNum.isEven ? Colors.blue[50]! : Colors.blue[50]!,
                        child: Center(child: Text(todoList[rowNum].todoItem, style: const TextStyle(fontSize: 20.0, color:Colors.black),)),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ]);
              }),

          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Expanded (
                flex: 1,
                child: ElevatedButton(
                  onPressed: deleteAll,
                  child: const Text('Del All', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, color:Colors.blue),),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _inputController,
                  decoration: const InputDecoration(
                    hintText: 'Enter a ToDo Item',
                    border: OutlineInputBorder(),

                  ),
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(width: 20),
              Expanded (
                flex: 1,
                child: ElevatedButton(
                  onPressed: addTask,
                  child: const Text('Add', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, color:Colors.blue),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
