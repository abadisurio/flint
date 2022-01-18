import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flint/database/database.dart';
import 'package:flint/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class MovieDao {
  final dbProvider = DatabaseProvider.dbProvider;

  // adds new movie to favorite
  Future<int?> createMovie(Movie movie) async {
    final db = await dbProvider.database;
    var result = db?.insert(movieTABLE, movie.toDatabaseJson());
    return result;
  }

  Future<void> createMovieFromJSON() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? movieJson;
    movieJson = json.decode("lib/data/movies.json");
    Batch? batch = db?.batch();
    movieJson?.map((e) {
      batch?.insert(
          movieTABLE,
          Movie(
                  id: e['movieId'],
                  title: e['title'],
                  posterURL: "assets/images/girls/img_1.jpeg",
                  genre: e['genre'],
                  level: 0)
              .toDatabaseJson());
    });
    // var result = db?.insert(movieTABLE, movie.toDatabaseJson());
    // var result = await batch?.commit(noResult: true);
    // return result;
  }

  Future<List<Movie>> getMovies({List<String>? columns, String? query}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>>? result;

    int? count = Sqflite.firstIntValue(
        await db?.rawQuery('SELECT COUNT(*) FROM $movieTABLE')
            as List<Map<String, Object?>>);
    dev.log("count " + count.toString());

    if (count != null && count == 0) {
      List<Map<String, dynamic>>? movieJson;

      // String data = await DefaultAssetBundle.of(App context).loadString("assets/data/movies.json");
      Future<String> data = rootBundle.loadString("assets/data/movies.json");

      // log(await data);

      movieJson = json.decode(await data).cast<Map<String, dynamic>>();
      // log("test");
      // log(movieJson.toString());
      Batch? batch = db?.batch();
      movieJson?.forEach((e) {
        // log("test2");
        dev.log(e['movieId'].toString());
        batch?.insert(
            movieTABLE,
            Movie(
                    id: e['movieId'],
                    title: e['title'],
                    posterURL: "assets/images/girls/img_1.jpeg",
                    genre: e['genres'],
                    level: Random().nextInt(5))
                .toDatabaseJson());
        // Movie(
        // id: Random().nextInt(10000),
        // title: itemsTemp[i]['name'],
        // posterURL: itemsTemp[i]['img'],
        // genre: itemsTemp[i]['genre'].join(' | '),
        // level: 1);
      });
      // log(batch . toString());
      await batch?.commit();
      // log(result!.length.toString());
    }

    if (query != null) {
      if (query.isNotEmpty) {
        result = await db?.query(movieTABLE,
            columns: columns, where: 'level = ?', whereArgs: ["%$query"]);
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
