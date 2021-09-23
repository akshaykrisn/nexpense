import 'dart:math';

import 'package:nexpense/transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nexpense/main.dart';

class SpendingChart extends StatelessWidget {
  final List<MyTransaction> items;

  const SpendingChart({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spending = <String, double>{};

    items.forEach(
      (item) => spending.update(
        item.transactionCategory,
        (value) => value + double.parse(item.money),
        ifAbsent: () => double.parse(item.money),
      ),
    );

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 360.0,
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: PieChart(
                PieChartData(
                  sections: spending
                      .map((category, amountSpent) => MapEntry(
                            category,
                            PieChartSectionData(
                              color: getCategoryColorChart(category),
                              radius: 100,
                              value: amountSpent,
                              showTitle: false,
                            ),
                          ))
                      .values
                      .toList(),
                  sectionsSpace: 0,
                ),
              ),
            )),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: spending.keys
                  .map((category) => _Indicator(
                        color: getCategoryColorChart(category),
                        text: category,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Color getCategoryColorChart(String category) {
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
}

class _Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const _Indicator({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 16.0,
          width: 16.0,
          color: color,
        ),
        const SizedBox(width: 4.0),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
