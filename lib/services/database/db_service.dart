import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '/models/contact.dart';

class DbService {
  /// Table name
  final String _tableName = "contacts";

  /// Make it Singleton
  DbService._();

  static final DbService _dbService = DbService._();

  factory DbService() => _dbService;

  Database? _database;

  /// CREATE A DATABASE
  Future<void> _createDatabase(Database db, int version) async {
    db.execute("""
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        phoneNumber TEXT NOT NULL
      )
    """);
  }

  /// INITIALIZE THE DATABASE
  Future<Database> _initDatabase() async {
    final String dbPath = await getDatabasesPath();
    final path = "$dbPath/localDatabase.db";
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  /// DATABASE GETTER
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  /// Method for getting contacts from the Database
  Future<List<Contact>> getContacts() async {
    final db = await database;
    final dbResponse = await db.rawQuery("SELECT * FROM $_tableName");
    List<Contact> contacts = dbResponse.isNotEmpty
        ? dbResponse.map((e) => Contact.fromJson(e)).toList()
        : [];
    return contacts;
  }

  /// Method for adding a contact to the Database
  Future<void> addContact({
    required String title,
    required String phoneNumber,
  }) async {
    try {
      final db = await database;
      await db.insert(_tableName, {
        'title': title,
        'phoneNumber': phoneNumber,
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error while adding a contact: $e");
      }
    }
  }

  /// Method for deleting a contact from the Database
  Future<void> deleteContact(int id) async {
    try {
      final db = await database;
      await db.delete(_tableName, where: "id == ?", whereArgs: [id]);
    } catch (e) {
      if (kDebugMode) {
        print('Error while deleting a contact: $e');
      }
    }
  }

  /// Method for editing a contact from the Database
  Future<void> editContact({
    required int id,
    required String newTitle,
    required String newPhone,
  }) async {
    try {
      final db = await database;
      await db.update(
          _tableName,
          {
            'title': newTitle,
            'phoneNumber': newPhone,
          },
          where: 'id == ?',
          whereArgs: [id]);
    } catch (e) {
      if (kDebugMode) {
        print('Error while editing a contact: $e');
      }
    }
  }
}
