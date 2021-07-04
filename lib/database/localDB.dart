import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class LocalDB {
  static Future<sql.Database> connectionOrCreate() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT)',
        );
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await LocalDB.connectionOrCreate();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object?>>> getAllData(String table) async {
    final db = await LocalDB.connectionOrCreate();
    return await db.query(table);
  }
}
