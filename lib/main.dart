import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Models
import 'database/database_helper.dart';
import 'models/transaction.model.dart';

// Widgets
import 'widgets/new_transaction.widget.dart';
import 'widgets/transaction_list.widget.dart';
import 'widgets/chart.widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Mate App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
        buttonColor: Colors.white,
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _userTransactions = [];
  final DatabaseHelper db = DatabaseHelper.instance;

  void _addNewTransaction({String title, double amount}) {
    final newTx = Transaction(
        amount: amount,
        title: title,
        date: DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()));

    db.insert(newTx);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
          (t) => DateFormat("yyyy-MM-dd hh:mm:ss").parse(t.date).isAfter(
                DateTime.now().subtract(
                  Duration(
                    days: 7,
                  ),
                ),
              ),
        )
        .toList();
  }

  void _refreshTransactions() async {
    final List<Transaction> tempList = await db.queryAllTransactions();
    setState(() {
      this._userTransactions = tempList;
    });
  }

  void _showAddTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransactionWidget(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Expenses',
          style: TextStyle(
            fontFamily: 'Open Sans',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _refreshTransactions(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionListWidget(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          hoverColor: Colors.white,
        ),
        onPressed: () => _showAddTransactionModal(context),
      ),
    );
  }
}
