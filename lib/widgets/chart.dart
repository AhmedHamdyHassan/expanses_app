import 'package:intl/intl.dart';

import '../widgets/chart_bar.dart';

import '../classes/transaction.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get getDaysOfChart {
    return List.generate(7, (index) {
      final currentWeekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (currentWeekDay.day == recentTransactions[i].date.day &&
            currentWeekDay.month == recentTransactions[i].date.month &&
            currentWeekDay.year == recentTransactions[i].date.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(currentWeekDay),
        'totalAmount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return getDaysOfChart.fold(0.0, (sum, item) {
      return sum += item['totalAmount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: getDaysOfChart.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['totalAmount'],
                  maxSpending == 0.0
                      ? 0.0
                      : (data['totalAmount'] as double) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
