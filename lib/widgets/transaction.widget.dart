import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Import Transaction model
import '../models/transaction.model.dart';

class TransactionWidget extends StatelessWidget {
  Transaction _tx;
  Map<String, Function> _transactionsFunctionMap;

  TransactionWidget(Transaction t, txFunctionMap) {
    this._tx = t;
    this._transactionsFunctionMap = txFunctionMap;
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
                  color: Theme.of(context).primaryColor,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Text(
                "\$${this._tx.amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this._tx.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                DateFormat().format(this._tx.date),
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onPressed: () => _transactionsFunctionMap["removeTransaction"](
                    this._tx.transactionId),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
