import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexpense/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'google_sheets_api.dart';
import 'loading_circle.dart';
import 'plus_button.dart';
import 'top_card.dart';
import 'transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User _user;

  // collect user input
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final textcontrollerCATEGORY = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;
  String dropdownValue = 'Others';

  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }
    return Scaffold(backgroundColor: Colors.grey[350], body: getHomeB());
  }

  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  // new transaction
  void _newTransaction() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                title: Text('ADD TRANSACTION'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Expense'),
                          CupertinoSwitch(
                            trackColor: Colors.red,
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          Text('Income'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Amount',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Where',
                              ),
                              controller: _textcontrollerITEM,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.white,
                                border: Border.all()),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                focusColor: Colors.white,
                                isExpanded: true,
                                value: dropdownValue,
                                icon:
                                    const Icon(Icons.arrow_circle_down_rounded),
                                style: TextStyle(color: Colors.white),
                                iconEnabledColor: Colors.black,
                                items: <String>[
                                  'Others',
                                  'Food',
                                  'Shopping',
                                  'Personal',
                                  'Transport',
                                  'Investment',
                                  'Bills',
                                  'Entertainment',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Category",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.black,
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    color: Colors.black,
                    child: Text('Enter', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enterTransaction();
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }

  // enter the new transaction into the spreadsheet
  void _enterTransaction() {
    if (_textcontrollerITEM.text == "") _textcontrollerITEM.text = "Unknown";
    GoogleSheetsApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
      dropdownValue,
    );
    setState(() {});
  }

  // Show chart
  void showChartFromHome(List<MyTransaction> items) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return SpendingChart(items: items);
            },
          );
        });
  }

  Center getHomeB() {
    return Center(
      child: Container(
        //width and height only defined for web
        // width: 480,
        // height: 1440,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TopNeuCard(
                  balance: (GoogleSheetsApi.calculateIncome() -
                          GoogleSheetsApi.calculateExpense())
                      .toString(),
                  income: GoogleSheetsApi.calculateIncome().toString(),
                  expense: GoogleSheetsApi.calculateExpense().toString(),
                  function: showChartFromHome),
              Expanded(
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Expanded(
                          child: GoogleSheetsApi.loading == true
                              ? LoadingCircle()
                              : ShaderMask(
                                  shaderCallback: (Rect rect) {
                                    return LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.purple,
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.purple
                                      ],
                                      stops: [
                                        0.0,
                                        0.05,
                                        0.95,
                                        1.0
                                      ], // 10% purple, 80% transparent, 10% purple
                                    ).createShader(rect);
                                  },
                                  blendMode: BlendMode.dstOut,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    itemCount: GoogleSheetsApi
                                        .currentTransactions.length,
                                    itemBuilder: (context, index) {
                                      index = GoogleSheetsApi
                                              .currentTransactions.length -
                                          index -
                                          1;
                                      return MyTransaction(
                                        transactionName: GoogleSheetsApi
                                            .currentTransactions[index]
                                            .transactionName,
                                        money: GoogleSheetsApi
                                            .currentTransactions[index].money,
                                        expenseOrIncome: GoogleSheetsApi
                                            .currentTransactions[index]
                                            .expenseOrIncome,
                                        transactionCategory: GoogleSheetsApi
                                            .currentTransactions[index]
                                            .transactionCategory,
                                      );
                                    },
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              PlusButton(
                function: _newTransaction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
