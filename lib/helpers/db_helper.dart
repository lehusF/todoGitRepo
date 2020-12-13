import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:todov1/models/task_model.dart';

class DbHelper{
  static Future<void> createDB(db, version){
    print('CREATE DB');
    return db.execute('CREATE TABLE tasks(id TEXT PRIMARY KEY, text TEXT, dateTime TEXT, isDone INTEGER)');
  }

  // get DB instanse
  static Future<Database> database()async{
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'tasks.db'), onCreate: createDB, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    var sqlDB = await DbHelper.database();
    await sqlDB.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> get(String table)async {
    var sqlDB = await DbHelper.database();
    return sqlDB.query(table);
  }

  static Future<void> updateTaskState(String id, int isDone)async {
    var sqlDB = await DbHelper.database();
    return sqlDB.rawQuery("UPDATE tasks SET isDone = '$isDone' WHERE id = '$id'");
  }

  static Future<void> removeTask(String id) async{
    var sqlDB = await DbHelper.database();
    return sqlDB.rawDelete("DELETE FROM tasks WHERE id = '$id'");
  }
}