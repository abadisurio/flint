import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flint/database/userToken.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:flint/database/database.dart';
import 'package:flint/model/movie.dart';
import 'package:flint/model/movie_details.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

class MovieDao {
  final TokenProvider tokenProvider = TokenProvider.tokenProvider;

  Future<List<MovieDetails>> getFilteredMovies() async {
    // void getFilteredMovies() async {
    // void getFilteredMovie() async {
    final token2 = await tokenProvider.token;
    if (token2 != null) {
      dev.log("ini token2: " + token2);
    }
    // Future.delayed(const Duration(seconds: 1), () {
    //   dev.log("ini token3: " + MovieDao().token.toString());
    // });
    // // List<Map<String, dynamic>>? result;
    // // // String token =
    // // //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjFmOTNlMjdlODg1NjAxMWIxNWZmMmMwIiwidXNlcm5hbWUiOiJhYmFkaXN1cmlvMyIsImlhdCI6MTY0Mzg1NTAwMiwiZXhwIjoxNjQ0NDU5ODAyfQ.Xw4If_vmGHn79SniiVHmOuo7FdY2ENJT1l3v5oEaHZM';
    // String url = 'http://10.0.2.2:3000/api/getFilteredMoviesWithDetail';
    // Map<String, String> requestHeaders = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': token ?? "hehe"
    // };
    // var client = http.Client();
    // dev.log(requestHeaders.toString());
    // dev.log("test");
    // try {
    //   final response =
    //       await client.get(Uri.parse(url), headers: requestHeaders);
    //   dev.log(response.body);

    //   // return MovieWithDetail.fromJson(jsonDecode(response.body));
    // } catch (err) {
    //   dev.log(err.toString());
    // } finally {
    //   client.close();
    // }
    return [];
  }
}
