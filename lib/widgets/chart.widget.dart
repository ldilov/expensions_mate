import 'package:expensions_mate/widgets/char_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Models
import '../models/transaction.model.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalAmount = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount,
      };
    });
  }

  double get totalSpendingsAmount {
    return groupedTransactionValues.fold(
      0.0,
      (sum, tObj) => sum + tObj['amount'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((data) {
          return ChartBar(
            data['day'].toString(),
            data['amount'],
            totalSpendingsAmount == 0.0
                ? 0.0
                : (data['amount'] as double) / totalSpendingsAmount,
          );
        }).toList(),
      ),
    );
  }
}
