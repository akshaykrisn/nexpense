import 'package:flutter/material.dart';

class MyTransaction extends StatelessWidget {
  final String transactionName;
  final String money;
  final String expenseOrIncome;
  final String transactionCategory;

  MyTransaction({
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome,
    required this.transactionCategory,
  });

  Color getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.red[400]!;
      case 'Shopping':
        return Colors.green[400]!;
      case 'Personal':
        return Colors.blue[400]!;
      case 'Transport':
        return Colors.purple[400]!;
      case 'Investment':
        return Colors.deepPurple[400]!;
      case 'Bills':
        return Colors.indigo[400]!;
      case 'Entertainment':
        return Colors.cyan[500]!;
      default:
        return Colors.black;
    }
  }

  IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.food_bank;
      case 'Shopping':
        return Icons.local_grocery_store;
      case 'Personal':
        return Icons.person;
      case 'Transport':
        return Icons.car_rental;
      case 'Investment':
        return Icons.arrow_upward;
      case 'Bills':
        return Icons.credit_card;
      case 'Entertainment':
        return Icons.movie;
      default:
        return Icons.money;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: RaisedButton(
          padding: EdgeInsets.all(15),
          color: Colors.grey[100],
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[500]),
                    child: Center(
                      child: Icon(
                        getCategoryIcon(transactionCategory),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transactionCategory,
                            style: TextStyle(
                              fontSize: 11,
                              color: getCategoryColor(transactionCategory),
                            )),
                        Text(transactionName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            )),
                      ])
                ],
              ),
              Text(
                (expenseOrIncome == 'expense' ? '-' : '+') + '\₹' + money,
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color:
                      expenseOrIncome == 'expense' ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
