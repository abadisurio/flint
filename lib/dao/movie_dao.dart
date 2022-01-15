import 'package:flint/database/database.dart';
import 'package:flint/model/movie.dart';

class MovieDao {
  final dbProvider = DatabaseProvider.dbProvider;

  // adds new movie to favorite
  Future<int?> createMovie(Movie movie) async {
    final db = await dbProvider.database;
    var result = db?.insert(movieTABLE, movie.toDatabaseJson());
    return result;
  }

  Future<List<Movie>> getMovies({List<String>? columns, String? query}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? result;
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db?.query(movieTABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query"]);
      }
    } else {
      result = await db?.query(movieTABLE, columns: columns);
    }

    List<Movie> movies = result != null
        ? result.map((e) => Movie.fromDatabaseJson(e)).toList()
        : [];
    return movies;
  }

  Future<int?> updateMovie(Movie movie) async {
    final db = await dbProvider.database;
    var result = await db?.update(movieTABLE, movie.toDatabaseJson(),
        where: "id = ?", whereArgs: [movie.id]);
    return result;
  }

  Future<int?> deleteMovie(int id) async {
    final db = await dbProvider.database;
    var result = await db?.delete(movieTABLE, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future deleteAllMovies() async {
    final db = await dbProvider.database;
    var result = await db?.delete(movieTABLE);
    return result;
  }
}
