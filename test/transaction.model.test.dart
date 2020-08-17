import '../lib/main.dart';
import 'package:flutter_test/flutter_test.dart';

// Transaction model impport
import '../lib/models/transaction.model.dart';

void main() {
  testWidgets('Transactions are different', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    Transaction t1 =
        Transaction(amount: 12.50, date: DateTime.now(), title: "Nike");
    Transaction t2 =
        Transaction(amount: 12.50, date: DateTime.now(), title: "Nike");

    expect(t1 == t2, false);
  });
}
