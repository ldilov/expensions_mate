import '../models/transaction.model.dart';
import 'package:flutter/material.dart';

// Widgets
import 'new_transaction.widget.dart';
import 'transaction_list.widget.dart';

class UserTransactionsWidget extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactionsWidget> {
  final List<Transaction> _userTransactions = [];

  void _addNewTransaction({String title, double amount}) {
    final newTx =
        Transaction(amount: amount, title: title, date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      NewTransactionWidget(_addNewTransaction),
      TransactionListWidget(this._userTransactions)
    ]);
  }
}
