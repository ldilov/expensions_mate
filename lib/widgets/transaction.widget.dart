import 'package:flutter/material.dart';

// Import Transaction model
import '../models/transaction.model.dart';

class TransactionWidget extends StatelessWidget {
  Transaction _tx;

  TransactionWidget(Transaction t) {
    this._tx =
        Transaction(id: t.id, amount: t.amount, title: t.title, date: t.date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: <Widget>[
        Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.purple, width: 2, style: BorderStyle.solid)),
            child: Text(
              this._tx.amount.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.purple,
              ),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this._tx.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            Text(this._tx.date.toString(),
                style: TextStyle(
                  color: Colors.grey,
                ))
          ],
        )
      ],
    ));
  }
}
