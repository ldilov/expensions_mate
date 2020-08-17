import 'package:flutter/material.dart';

// Models
import 'models/transaction.model.dart';

// Widgets
import 'widgets/transaction.widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'Shoes',
      amount: 99.12,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Dress',
      amount: 12.15,
      date: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          Column(
            children: transactions.map((tx) {
              print("qweqweqw");
              return TransactionWidget(tx);
            }).toList(),
          )
        ],
      ),
    );
  }
}
