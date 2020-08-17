import 'package:flutter/material.dart';

class NewTransactionWidget extends StatelessWidget {
  final Function _addTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransactionWidget(this._addTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
            ),
            FlatButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
              onPressed: () {
                _addTransaction(
                    title: titleController.text,
                    amount: double.parse(amountController.text));
              },
            ),
          ],
        ),
      ),
    );
  }
}
