import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';

class SplashPage extends StatelessWidget {
	final GoogleSignIn _googleSignIn = GoogleSignIn();
	final FirebaseAuth _auth = FirebaseAuth.instance;
	
	SplashPage();
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
				body: Container(
					decoration: BoxDecoration(
						color: Color.fromRGBO(0, 127, 235, 1.0),
					),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Padding(
								padding: const EdgeInsets.all(12.0),
								child: Text("Please sign in", style: TextStyle(color: Colors.white),),
							),
							Center(
								child: MaterialButton(
									color: Colors.white,
									child: Row(
										mainAxisSize: MainAxisSize.min,
										crossAxisAlignment: CrossAxisAlignment.center,
										children: <Widget>[
											Image.asset(
												'assets/google.png',
												width: 25.0,
											),
											Padding(
												child: Text(
													"Sign in with Google",
													style:  TextStyle(
														fontFamily: 'Roboto',
														color: Color.fromRGBO(68, 68, 76, .8)
													),
												),
												padding: new EdgeInsets.only(left: 15.0),
											),
										],
									),
									onPressed: () =>
											_handleSignIn().then((FirebaseUser user) {
												Navigator.pushAndRemoveUntil(
														context,
														MaterialPageRoute(
																builder: (context) => HomePage(user: user)),
														ModalRoute.withName('/expenses'));
											}).catchError((e) => print(e))),
							)
						],
					),
				));
	}
	
	Future<FirebaseUser> _handleSignIn() async {
		GoogleSignInAccount googleUser = await _googleSignIn.signIn();
		GoogleSignInAuthentication googleAuth = await googleUser.authentication;
		FirebaseUser user = await _auth.signInWithGoogle(
			accessToken: googleAuth.accessToken,
			idToken: googleAuth.idToken,
		);
		return user;
	}
}
