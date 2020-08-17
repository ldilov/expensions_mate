import 'package:flutter/material.dart';

// Models
import 'models/transaction.model.dart';

// Widgets
import 'widgets/new_transaction.widget.dart';
import 'widgets/transaction.widget.dart';
import 'widgets/transaction_list.widget.dart';
import 'widgets/user_transactions.widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Mate App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text("Chart!"),
              elevation: 5,
            ),
          ),
          UserTransactionsWidget()
        ],
      ),
    );
  }
}
