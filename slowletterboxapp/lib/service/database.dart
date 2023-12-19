import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:slowletterboxapp/models/letter.dart';

class DBHelper {
  Future _openDB() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'letter.db');

    bool exist = await databaseExists(path);
    if (!exist) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
    }

    final db = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: (Database db, int version) => {},
      onUpgrade: (Database db, int oldVersion, int newVersion) => {},
    );

    _onCreate(db);

    return db;
  }

  Future _onCreate(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS letters (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, contents TEXT NOT NULL, letterDate int NOT NULL)''');
  }

  Future insertDB(Letter item) async {
    final db = await _openDB();
    int res = await db.insert(
      'letters',
      {'title': item.title, 'contents': item.contents, 'letterDate': item.date},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res;
  }

  Future getDB(int startDate, int endDate) async {
    final db = await _openDB();
    final List<Map<String, dynamic>> res = await db.query(
      'letters',
      where: 'letterDate<=? and letterDate>=?',
      whereArgs: [endDate, startDate],
    );

    List<Letter> letterList = [];
    if (res.isEmpty) return letterList;
    letterList = List.generate(res.length, (index) {
      return Letter(
        id: res[index]["id"],
        title: res[index]["title"],
        contents: res[index]["contents"],
        date: res[index]["letterDate"],
      );
    });

    return letterList;
  }

  Future deleteDB(int id) async {
    final db = await _openDB();
    await db.delete(
      'letters',
      where: 'id=?',
      whereArgs: [id],
    );
    return id;
  }

  Future<void> executeSQL() async {
    final db = await _openDB();
    await db.execute("DROP TABLE IF EXISTS letters");
  }
}
