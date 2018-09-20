import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splitty/expense/expense_form.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _expenseInputPosition;
  Animation<Offset> _bottomNavbarPosition;
  Animation<double> _floatingButtonScale;
  Animation<double> _expenseListScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);

    //Offset pos = Offset(20.0, -200.0);
    _expenseInputPosition = Tween<Offset>(
            begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _bottomNavbarPosition = Tween<Offset>(
            begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _floatingButtonScale = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _expenseListScale = Tween<double>(begin: 1.0, end: 0.85)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _modalBottomSheetMenu() {
    /*showBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
                height: 1000.0,
                child: ExpenseForm(user: widget.user)
            ),
          );
        });*/
    showModalBottomSheet<Container>(
        context: context,
        builder: (builder) {
          return Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: new Container(
                child: new Center(
              child: new Text("This is a modal sheet"),
            )),
          );
        });
  }

  Widget _buildExpenseItem(expenseTotal, expenseDescription) {
    return Container(
        margin: EdgeInsets.only(bottom: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromRGBO(101, 101, 101, 0.13),
                  offset: Offset(1.0, 1.0),
                  blurRadius: 4.0)
            ]),
        child: Padding(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 14.0, bottom: 14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(expenseDescription,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.normal)),
              Text(expenseTotal + "€",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.normal))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(50, 120, 253, 1.0),
      body: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(50.0, 40.0, 50.0, 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "EXPENSES",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'RobotoMono',
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),/*
              Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "last",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.w300),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 2.5, left: 1.5),
                      child: Icon(
                        Icons.filter_list,
                        size: 12.0,
                      ))
                ],
              ))*/
            ],
          ),
        ),
        Expanded(
            child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
              color: Colors.white,
            )),
            Positioned.fill(
                top: -35.0,
                child: ScaleTransition(
                    scale: _expenseListScale,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(252, 252, 252, 1.0),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.16),
                                      offset: Offset(0.0, 3.0),
                                      blurRadius: 6.0)
                                ],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0))),
                            child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection('expenses')
                                    .where("owner", isEqualTo: widget.user.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData)
                                    return const Text('Loading...');
                                  return new ListView.builder(
                                      itemCount: snapshot.data.documents.length,
                                      padding: const EdgeInsets.only(
                                          top: 15.0, left: 15.0, right: 15.0),
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot ds =
                                            snapshot.data.documents[index];
                                        return _buildExpenseItem(
                                            ds['total'], ds['description']);
                                      });
                                }))))),
            Positioned.fill(
                bottom: -48.0,
                top: -35.0,
                child: Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: SlideTransition(
                        position: _expenseInputPosition,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Color.fromRGBO(101, 101, 101, 0.13),
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 4.0)
                              ]),
                          child: ExpenseForm(
                            user: widget.user,
                            expenseCardController: _controller,
                          ),
                        ))))
          ],
        ))
      ]),
      bottomNavigationBar: SlideTransition(
        position: _bottomNavbarPosition,
        child: BottomAppBar(
          color: Colors.white,
          hasNotch: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.assignment, size: 25.0),
                onPressed: () => _controller.reverse(),
              ),
              IconButton(
                icon: Icon(
                  Icons.group,
                  size: 30.0,
									color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _floatingButtonScale,
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 5.0, color: Colors.white),
          ),
          child: FloatingActionButton(
            elevation: .0,
            child: Icon(Icons.add, size: 35.0),
            backgroundColor: const Color.fromRGBO(0, 88, 255, 1.0),
            onPressed: () => _controller.forward(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
