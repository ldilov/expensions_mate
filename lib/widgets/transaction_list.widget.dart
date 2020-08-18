import 'package:flutter/widgets.dart';

// Models import
import '../models/transaction.model.dart';

// Widgets
import '../widgets/transaction.widget.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionListWidget(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: ListView.builder(
        itemBuilder: (context, index) => TransactionWidget(transactions[index]),
        itemCount: transactions.length ,
      ),
    );
  }
}
