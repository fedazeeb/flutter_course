import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'student.dart';

class DBLogsManager {
  static final DBLogsManager _instance = DBLogsManager._internal();
  Future<Database>? databas;
  factory DBLogsManager() {
    return _instance;
  }

  DBLogsManager._internal({this.datebase,this.databas}) {
    openDB();
  }
  Database? datebase;

  Future openDB() async {
    if (datebase == null) {
      datebase = await openDatabase(
          join(await getDatabasesPath(), "student.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE student(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,course TEXT)");
      });
    }
  }

  Future<int> insertStudent(ActionLogs student) async {
    await openDB();
    return await datebase!.insert('student', student.toMap());
  }

  Future<List<ActionLogs>> getStudentList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await datebase!.query('student');

    return List.generate(maps.length, (index) {
      return ActionLogs(
          id: maps[index]['id'],
          name: maps[index]['name'],
          course: maps[index]['course']);
    });
  }

  Future<int> updateStudent(ActionLogs student) async {
    await openDB();
    return await datebase!.update('student', student.toMap(),
        where: 'id=?', whereArgs: [student.id]);
  }

  Future<void> deleteStudent(int id) async {
    await openDB();
    await datebase!.delete("student", where: "id = ? ", whereArgs: [id]);
  }
}
