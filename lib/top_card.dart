import 'package:nexpense/chart.dart';
import 'package:nexpense/google_sheets_api.dart';
import 'package:nexpense/homepage.dart';
import 'package:nexpense/transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TopNeuCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expense;
  final Function function;

  TopNeuCard({
    required this.balance,
    required this.expense,
    required this.income,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //SpendingChart(items: getItemList()),
              createButton(Colors.black, "S P E N D I N G\nA N A L Y S I S"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Income',
                                style: TextStyle(color: Colors.white70)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('\₹' + income,
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Expense',
                                style: TextStyle(color: Colors.white70)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('\₹' + expense,
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.black38,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade600,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ]),
      ),
    );
  }

  RaisedButton createButton(Color color, String name) {
    return RaisedButton(
      child: Container(
        margin: EdgeInsets.fromLTRB(6, 20, 6, 20),
        //padding: EdgeInsets.all(20),
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ),
      onPressed: () {
        function(getItemList());
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      color: Colors.black45,
      elevation: 16,
    );

    // return Padding(
    //     padding: EdgeInsets.fromLTRB(84, 16, 84, 16),
    //     child: RaisedButton(
    //       elevation: 16,
    //       color: color,
    //       padding: EdgeInsets.all(16),
    //       onPressed: () {
    //         function(getItemList());
    //       },
    //       textColor: Colors.white70,
    //       child: Center(
    //         child: Text(
    //           name,
    //           style: TextStyle(fontWeight: FontWeight.bold),
    //         ),
    //       ),
    //       shape:
    //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
    //     ));
  }

  List<MyTransaction> getItemList() {
    List<MyTransaction> thisone = [];
    for (int i = 0; i < GoogleSheetsApi.currentTransactions.length; i++) {
      if (GoogleSheetsApi.currentTransactions[i].expenseOrIncome == 'expense') {
        thisone.add(GoogleSheetsApi.currentTransactions[i]);
      }
    }
    return thisone;
  }
}
