import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              title: Text("Balance"),
              icon: Icon(Icons.assignment)
          ),
          BottomNavigationBarItem(
            title: Text("Account"),
            icon: Icon(Icons.assignment_ind)
          )
        ])
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: null),
    );
  }
}