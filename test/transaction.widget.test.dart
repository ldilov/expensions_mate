import 'package:flutter_test/flutter_test.dart';

// Model import
import '../lib/models/transaction.model.dart';

// Widgets import
import '../lib/widgets/transaction.widget.dart';

import 'package:flutter/material.dart';

void main() {
  var date = DateTime.now();
  testWidgets('TransactionWidget has a title', (WidgetTester tester) async {
    var tx =
        Transaction(amount: 20.05, title: "SampleWidget", date: DateTime.now());
    var txWidget = TransactionWidget(tx);
    await tester.pumpWidget(txWidget);

    final titleFinder = find.text("SampleWidget");

    expect(titleFinder, findsOneWidget);
  });
}
