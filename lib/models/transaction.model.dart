import 'package:flutter/foundation.dart';

class Transaction {
  int _id;
  static int id = 0;
  String title;
  double amount;
  DateTime date;

  Transaction({@required title, @required amount, @required date}) {
    this._id = Transaction.id;
    this.title = title;
    this.amount = amount;
    this.date = date;
    Transaction.id += 1;
  }
}
