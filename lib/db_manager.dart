/// db_manager.dart
///
/// This Dart file defines the `DatabaseHelper` class, a singleton class
/// responsible for managing SQLite database operations in the application.
///

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

/// The `DatabaseHelper` class is a singleton class responsible for managing
/// SQLite database operations in the application.
class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'category';
  static final tableContact = 'contact';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnLName = 'lname';
  static final columnMobile = 'mobile';
  static final columnEmail = 'email';
  static final columnCategory = 'cat';
  static final columnProfile = 'profile';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  /// Returns a Future containing the initialized database.
  Future<Database> get database async => _database ??= await _initDatabase();

  /// Returns a Future containing the initialized database or null if not initialized.
  Future<Database?> get database1 async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  /// Initializes the SQLite database.
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  /// Callback method invoked when creating the database.
  Future _onCreate(Database db, int version) async {
    // Create the 'category' table.
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL 
          )
          ''');

    // Create the 'contact' table.
    await db.execute('''
          CREATE TABLE $tableContact (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL, 
            $columnLName TEXT NOT NULL, 
            $columnMobile TEXT NOT NULL, 
            $columnEmail TEXT NOT NULL, 
            $columnCategory TEXT NOT NULL, 
            $columnProfile TEXT NOT NULL
          )
          ''');
  }

  /// Inserts a new row into the 'category' table.
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(table, row);
  }

  /// Inserts a new row into the 'contact' table.
  Future<int> insertContact(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(tableContact, row);
  }

  /// Queries all rows from the 'category' table.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  /// Queries all rows from the 'contact' table.
  Future<List<Map<String, dynamic>>> queryAllRowsofContact() async {
    Database db = await instance.database;
    return await db.query(tableContact);
  }

  /// Queries the number of rows in the 'category' table.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $table')) ??
        0;
  }

  /// Updates a row in the 'category' table.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  /// Deletes a row from the 'category' table.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  /// Deletes a row from the 'contact' table.
  Future<int> deleteContact(int id) async {
    Database db = await instance.database;
    return await db.delete(tableContact, where: '$columnId = ?', whereArgs: [id]);
  }
}
