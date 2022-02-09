import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'logs.dart';

class DBActionLogsManager {
  static final DBActionLogsManager _instance = DBActionLogsManager._internal();
  Future<Database>? databas;

  factory DBActionLogsManager() {
    return _instance;
  }

  DBActionLogsManager._internal({this.datebase, this.databas}) {
    openDB();
  }

  Database? datebase;

  Future openDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    // Delete the database
    // await deleteDatabase(path);

    // open the database
    datebase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          "CREATE TABLE logs(id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT,actionname TEXT,date TEXT)");
    });
  }

  // Future checkDb() async {
  //   openDB();
  //   Directory documentDirectory = await getApplicationDocumentsDirectory();
  //   //var db = await getDatabasesPath();
  //   var dbPath = join(documentDirectory.path, "demo.db");
  //   bool exist = await databaseExists(dbPath);
  //   print(exist);
  //   return exist;
  // }

  Future<int> insertLog(Logs log) async {
    await openDB();
    return await datebase!.insert('logs', log.toMap());
  }

  Future<List<Logs>> getLogList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await datebase!.query('logs');

    return List.generate(maps.length, (index) {
      return Logs(
        id: maps[index]['id'],
        username: maps[index]['username'],
        actionname: maps[index]['actionname'],
        date: maps[index]['date'],
      );
    });
  }

  Future<int> updateLog(Logs log) async {
    await openDB();
    return await datebase!
        .update('log', log.toMap(), where: 'id=?', whereArgs: [log.id]);
  }

  Future<void> deleteLog(int id) async {
    await openDB();
    await datebase!.delete("log", where: "id = ? ", whereArgs: [id]);
  }
}
