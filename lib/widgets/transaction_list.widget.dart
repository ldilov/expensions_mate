import 'dart:collection';

import 'package:flutter/widgets.dart';

// Models import
import '../models/transaction.model.dart';

// Widgets
import '../widgets/transaction.widget.dart';

class TransactionListWidget extends StatefulWidget {
  final List<Transaction> transactions;

  TransactionListWidget(this.transactions);

  @override
  _TransactionListWidgetState createState() => _TransactionListWidgetState();
}

class _TransactionListWidgetState extends State<TransactionListWidget> {
  void removeTransaction(int id) {
    for (int i = 0; i < widget.transactions.length; i++) {
      if (id == widget.transactions[i].transactionId) {
        setState(() {
          widget.transactions.removeAt(i);
        });
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: ListView.builder(
        itemBuilder: (context, index) =>
            TransactionWidget(widget.transactions[index], {
          "removeTransaction": removeTransaction,
        }),
        itemCount: widget.transactions.length,
      ),
    );
  }
}
