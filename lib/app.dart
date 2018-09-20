import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';
import 'splash.dart';

class Splitty extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _SplittyState createState() => _SplittyState();
}

class _SplittyState extends State<Splitty> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return new MaterialApp(
      title: 'Splitty',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/expenses': (BuildContext context) => HomePage()
      },
    );
  }
}
