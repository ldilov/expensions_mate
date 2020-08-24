import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// Models
import 'database/database_helper.dart';
import 'models/transaction.model.dart';

// Widgets
import 'widgets/new_transaction.widget.dart';
import 'widgets/transaction_list.widget.dart';
import 'widgets/chart.widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

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

  void _addNewTransaction({String title, double amount, DateTime date}) {
    final newTx = Transaction(
      amount: amount,
      title: title,
      date: DateFormat("yyyy-MM-dd hh:mm:ss")
          .format(date != null ? date : DateTime.now()),
    );

    (() async {
      await db.insert(newTx);
    })();

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
        .toList()
        .reversed
        .toList();
  }

  void _refreshTransactions() async {
    final List<Transaction> tempList = await db.queryAllTransactions();
    setState(() {
      this._userTransactions = tempList;
    });
  }

  Future<List<Transaction>> _getAllTransactions() async {
    List<Transaction> result = (await db.queryAllTransactions()).toList();
    return result != null && result.isNotEmpty ? result : [];
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
    final appBar = AppBar(
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
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FutureBuilder<List<Transaction>>(
              future: _getAllTransactions(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Transaction>> snapshot) {
                if (snapshot.hasData) {
                  this._userTransactions = snapshot.data;
                  return Column(
                    children: [
                      Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.3,
                        child: Chart(_userTransactions),
                      ),
                      Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.6,
                        child: TransactionListWidget(_recentTransactions, db),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                }
              },
            ),
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
