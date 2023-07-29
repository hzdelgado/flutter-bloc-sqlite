import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabase {
  static final SqliteDatabase _instance = SqliteDatabase._internal();

  factory SqliteDatabase() {
    return _instance;
  }

  SqliteDatabase._internal();

  static Future<void> createTables(Database db) async {
    await db.execute(
        '''CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, done INTEGER)''');
  }

  static Future<String> _getDatabasePath() async {
    final libraryDirectory = await getApplicationDocumentsDirectory();
    final path = join(libraryDirectory.path, 'database.db');
    return path;
  }

  static Future<Database> db() async {
    final path = await _getDatabasePath();

    return openDatabase(path, onCreate: ((db, version) async {
      await createTables(db);
    }), version: 1);
  }

  static Future<void> deleteDb() async {
    final path = await _getDatabasePath();
    deleteDatabase(path);
  }
}
