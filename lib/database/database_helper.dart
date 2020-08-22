import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Model
import "../models/transaction.model.dart" as model;

// database table schema
final String tableTransactions = 'transactions';
final String columnId = 'transaction_id';
final String columnTransactionAmount = 'amount';
final String columnTransactionTitle = 'title';
final String columnTransactionDate = 'date';

class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "expense_local_storage.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableTransactions (
                $columnId INTEGER NOT NULL,
                $columnTransactionTitle TEXT NOT NULL,
                $columnTransactionAmount REAL NOT NULL,
                $columnTransactionDate TEXT NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(model.Transaction t) async {
    Database db = await database;
    int id = await db.insert(tableTransactions, t.toMap());
    return id;
  }

  Future<model.Transaction> queryTransaction(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableTransactions,
        columns: [
          columnId,
          columnTransactionTitle,
          columnTransactionAmount,
          columnTransactionDate
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return model.Transaction.fromMap(maps.first);
    }
    return null;
  }

  Future<List<model.Transaction>> queryAllTransactions() async {
    Database db = await database;
    final List<model.Transaction> transactions = [];

    // get all rows
    List<Map> result = await db.query(tableTransactions);
    result.forEach((row) => {transactions.add(model.Transaction.fromMap(row))});

    return transactions;
  }

  Future<int> delete(int tId) async {
    Database db = await database;
    print("called");
    return await db
        .delete(tableTransactions, where: '$columnId = ?', whereArgs: [tId]);
  }

  // TODO: update(Word word)
}
