import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Transaction {
  int _id;
  static int id = 0;
  String title;
  double amount;
  String date;

  Transaction({@required title, @required amount, @required date}) {
    this._id = Transaction.id;
    this.title = title;
    this.amount = amount;
    this.date = date;
    Transaction.id += 1;
  }

  Transaction.fromMap(Map<String, dynamic> map) {
    this._id = map['transaction_id'];
    this.title = map['title'];
    this.amount = map['amount'];
    print(map['date']);
    this.date = map['date'];
  }

  int get transactionId {
    return this._id;
  }

  // Equality operator
  @override
  bool operator ==(t) => this._id == t.transactionId;

  Map<String, dynamic> toMap() {
    return {
      "transaction_id": this._id.toString(),
      "title": this.title,
      "amount": this.amount.toStringAsFixed(2),
      "date": this.date
    };
  }
}
