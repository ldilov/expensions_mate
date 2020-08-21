import 'dart:collection';

import 'package:flutter/material.dart';
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
  void _removeTransaction(int id) {
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
      height: 380,
      child: widget.transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  child: Image.asset("assets/images/waiting.png",
                      fit: BoxFit.cover),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) =>
                  TransactionWidget(widget.transactions[index], {
                "removeTransaction": _removeTransaction,
              }),
              itemCount: widget.transactions.length,
            ),
    );
  }
}
