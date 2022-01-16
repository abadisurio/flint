import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';

const movieTABLE = 'Movie';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "ReactiveFlint.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $movieTABLE("
        "id INTEGER PRIMARY KEY, "
        "title TEXT, "
        "genre TEXT, "
        "level INTEGER"
        ") ");
  }
}
