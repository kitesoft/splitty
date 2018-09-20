import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseForm extends StatefulWidget {
  final FirebaseUser user;
  final AnimationController expenseCardController;

  ExpenseForm({@required this.user, @required this.expenseCardController});

  @override
  ExpenseFormState createState() => ExpenseFormState();
}

class ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _totalController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Insert new Expense",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'RobotoMono',
                        //color: Color.fromRGBO(42, 203, 110, 1.0),
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        widget.expenseCardController.reverse();
                      })
                ],
              ),
              buildFormInputs(context)
            ],
          ),
        ));
  }

  Widget buildFormInputs(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: TextFormField(
            controller: _totalController,
            decoration: InputDecoration(
                labelText: "Expense total",
                labelStyle: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.normal)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter expense total';
              }
            },
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
                labelText: "Expense description",
                labelStyle: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.normal)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter expense description';
              }
            },
          ),
        ),
        FlatButton(
          color: Color.fromRGBO(0, 88, 255, 1.0),
          textColor: Colors.white,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              CollectionReference expenses =
                  Firestore.instance.collection('expenses');
              Firestore.instance.runTransaction((Transaction tx) async {
                await expenses.add({
                  'total': _totalController.text,
                  'description': _descriptionController.text,
                  'owner': widget.user.uid
                });
                _totalController.clear();
                _descriptionController.clear();
                FocusScope.of(context).requestFocus(new FocusNode());
                widget.expenseCardController.reverse();
              });
            }
          },
          child: Text("Save", style: TextStyle(fontSize: 14.0)),
        )
      ],
    );
  }
}
