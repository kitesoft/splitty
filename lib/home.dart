import 'package:flutter/material.dart';
import 'package:splitty/expense/expense.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Expense> _expensesList = List();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(50, 120, 253, 1.0),
      body: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Container(
          constraints: new BoxConstraints.expand(
            height: 55.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0.0, 3.0),
                  blurRadius: 6.0)
            ],
          ),
          margin: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 20.0),
          child: Stack(overflow: Overflow.visible, children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                  child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('15€',
                        style: TextStyle(
                            fontSize: 23.0, fontFamily: 'RobotoMono')),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Icon(Icons.arrow_upward,
                              size: 12.0, color: Colors.red),
                          Text("GIVE",
                              style: TextStyle(
                                  fontSize: 11.0,
                                  fontFamily: 'RobotoMono',
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500))
                        ])
                  ],
                ),
              )),
              Expanded(
                  child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('25€',
                        style: TextStyle(
                          fontSize: 23.0,
                          fontFamily: 'RobotoMono',
                        )),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_downward,
                            size: 12.0,
                            color: Colors.green,
                          ),
                          Text("RECEIVE",
                              style: TextStyle(
                                  fontSize: 11.0,
                                  fontFamily: 'RobotoMono',
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500))
                        ])
                  ],
                ),
              ))
            ]),
            Positioned(
                child: Container(
                  child: Icon(
                    Icons.swap_vertical_circle,
                    color: Color.fromRGBO(50, 120, 253, 1.0),
                    size: 23.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(width: 1.0, color: Colors.white),
                  ),
                ),
                left: -25.0 / 2.0,
                top: (55.0 / 2.0) + (-25.0 / 2.0))
          ]),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 50.0),
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
              ),
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
              ))
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
                        child: ListView.builder(
                          padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
                          itemCount: _expensesList.length,
                          itemExtent: 55.0,
                          itemBuilder: (BuildContext context, index) {
                            return Text(
                              "TEST CARD",
                              style: TextStyle(color: Colors.red),
                            );
                          },
                        ))))
          ],
        ))
      ]),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        hasNotch: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.assignment, size: 25.0),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.group,
                size: 30.0,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border:
              Border.all(width: 5.0, color: Color.fromRGBO(250, 250, 250, 1.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, .09),
                    offset: Offset(0.0, -2.0),
                    blurRadius: 6.0)
                .scale(-1.0)
          ],
        ),
        child: FloatingActionButton(
          elevation: 1.0,
          child: Icon(Icons.add, size: 35.0),
          backgroundColor: const Color.fromRGBO(0, 88, 255, 1.0),
          onPressed: _createExpense,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _createExpense() {
    setState(() {
      _expensesList.add(Expense(10.0));
      print(_expensesList.length);
    });
  }
}
