import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Creating database helper class to store the data and retreive the data.
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
          CREATE TABLE my_table(
         id INTEGER PRIMARY KEY,
         name TEXT,
        age INTEGER
        )
        ''');
  }

  Future<int> insertData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('my_table', row);
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database db = await instance.database;
    return await db.query('my_table');
  }
}
