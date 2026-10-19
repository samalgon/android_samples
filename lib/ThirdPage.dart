import 'package:flutter/material.dart';
import 'DataRepository.dart';

class ThirdPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => ThirdPageState();
}

class ThirdPageState extends State<StatefulWidget>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Third Page")),
    body: Center(child:
        Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(child:  Text("Welcome back " + DataRepository.login ),
            onPressed: () {
              Navigator.of(context).pop(true);
            }
            ),//return to previous
          ],
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
  }
}