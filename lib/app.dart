import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';
import 'splash.dart';
import 'login.dart';

class Splitty extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _SplittyState createState() => _SplittyState();
}

class _SplittyState extends State<Splitty> {
  FirebaseUser _user;

  void _setUser(FirebaseUser user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return new MaterialApp(
      title: 'Splitty',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashPage(_setUser),
      routes: <String, WidgetBuilder>{
        '/expenses': (BuildContext context) => HomePage()
      },
    );
  }
}
