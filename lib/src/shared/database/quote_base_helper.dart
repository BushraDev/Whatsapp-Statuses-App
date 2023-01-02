import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:statusesapp/src/shared/database/quote_db_schema/quote_db_schema.dart';

class QuoteBaseHelper {
  static Database _db;

  Future<Database> get db async {
    // If database exists, return database
    if (_db != null)
      return _db;

    // If database don't exists, create one
    else {
      _db = await _initDB();

      return _db;
    }
  }

  _initDB() async {
    const int _version = 1;
    const String _databaseName = "quoteBase.db";
    String _dbPath = await getDatabasesPath();
    String _dbFullPath = join(_dbPath, _databaseName);

    return await openDatabase(_dbFullPath,
        version: _version, onCreate: _onCreate);
  }

  // Creating tables with cols
  void _onCreate(Database db, int version) async {
    await db
        .execute(
      "create table " +
          QuoteDbSchema.quoteTable.name +
          "(" +
          QuoteDbSchema.quoteTable.cols.quote +
          " TEXT NOT NULL ," +
          QuoteDbSchema.quoteTable.cols.author +
          " TEXT NOT NULL ," +
          QuoteDbSchema.quoteTable.cols.category +
          " TEXT NOT NULL "
              ")",
    )
        .then((_) {
      print("${QuoteDbSchema.quoteTable.name} table created successfully");
    });

    await db
        .execute(
      "create table " +
          QuoteDbSchema.categoriesTable.name +
          "(" +
          QuoteDbSchema.categoriesTable.cols.name +
          " TEXT NOT NULL "
              ")",
    )
        .then((_) {
      print("${QuoteDbSchema.categoriesTable.name} table created successfully");
    });

    await db
        .execute(
      "create table " +
          QuoteDbSchema.favoritesTable.name +
          "(" +
          QuoteDbSchema.favoritesTable.cols.quote +
          " TEXT NOT NULL UNIQUE," +
          QuoteDbSchema.favoritesTable.cols.author +
          " TEXT NOT NULL "
              ")",
    )
        .then((_) {
      print("${QuoteDbSchema.favoritesTable.name} table created successfully");
    });
  }
}
