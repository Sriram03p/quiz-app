import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:quiz_ap/models/user_score.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quiz_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE leaderboard (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userName TEXT NOT NULL,
        score INTEGER NOT NULL,
        dateTime TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertScore(UserScore score) async {
    final db = await instance.database;
    return await db.insert('leaderboard', score.toMap());
  }

  Future<List<UserScore>> getScores() async {
    final db = await instance.database;
    final maps = await db.query('leaderboard');
    return List.generate(maps.length, (i) => UserScore.fromMap(maps[i]));
  }

  Future<int> clearScores() async {
    final db = await instance.database;
    return await db.delete('leaderboard');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}