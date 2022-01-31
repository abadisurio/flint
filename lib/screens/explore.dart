import 'dart:convert';

import 'package:flint/model/movie_with_detail.dart';
import 'package:flint/widget/explore_movie.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

import 'package:flint/bloc/movie_bloc.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  final MovieBloc movieBloc = MovieBloc();

  MovieWithDetail? filteredMovies;

  Future<MovieWithDetail> getFilteredMovie() async {
    // void getFilteredMovie() async {
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjFmMDFkYTVkNDkzNzMwMjVmNTA0MDQ1IiwiZW1haWwiOiJhQGIuYyIsImlhdCI6MTY0MzYxODgwNCwiZXhwIjoxNjQzNjI2MDA0fQ.a-ZwUlp8-eMaqqZMJY0XQ0rA7Vv-IufV5RQiWlBsVkQ';
    String url = 'http://10.0.2.2:3000/api/getFilteredMoviesWithDetail';
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };
    var client = http.Client();
    dev.log("test");
    try {
      final response =
          await client.get(Uri.parse(url), headers: requestHeaders);
      dev.log(response.body);

      return MovieWithDetail.fromJson(jsonDecode(response.body));
    } finally {
      client.close();
    }
  }

  void requestFilteredMovies() async {
    final _filteredMovies = await getFilteredMovie();
    setState(() {
      filteredMovies = _filteredMovies;
    });
  }

  @override
  void initState() {
    super.initState();

    dev.log("filteredMovies " + filteredMovies.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieWithDetail>(
        future: getFilteredMovie(),
        builder: (context, AsyncSnapshot<MovieWithDetail> snapshot) {
          final hasData = snapshot.hasData;
          if (hasData) {
            final data = snapshot.data!;
            dev.log("snapshot " + snapshot.hasData.toString());
            dev.log("data " + data.toString());
            return ExploreMovie(movieWithDetail: data);
          }
          return const CircularProgressIndicator();
        });
  }
}
