import 'dart:convert';
import 'dart:developer';
import 'package:flint/model/movie_details.dart';
import 'package:flint/widget/explore_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flint/bloc/movie_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    // dev.log("ini token lagi " + token.toString());

    // String token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjFmOTNlMjdlODg1NjAxMWIxNWZmMmMwIiwidXNlcm5hbWUiOiJhYmFkaXN1cmlvMyIsImlhdCI6MTY0Mzg1NTAwMiwiZXhwIjoxNjQ0NDU5ODAyfQ.Xw4If_vmGHn79SniiVHmOuo7FdY2ENJT1l3v5oEaHZM';
    String url = 'http://10.0.2.2:3000/api/getFilteredMoviesWithDetail';
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token ?? "hehe"
    };
    var client = http.Client();
    // dev.log(requestHeaders.toString());
    // dev.log("test");
    try {
      final response =
          await client.get(Uri.parse(url), headers: requestHeaders);
      // dev.log(response.body);

      return MovieWithDetail.fromJson(jsonDecode(response.body));
    } catch (err) {
      // dev.log("err " + err.toString());
      return MovieWithDetail.fromJson({
        "status": "success",
        "data": {"movies": []}
      });
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
    movieBloc.getFilteredMovies();
    // dev.log("filteredMovies " + filteredMovies.toString());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MovieDetails>>(
        stream: movieBloc.movies,
        builder: (context, AsyncSnapshot<List<MovieDetails>> snapshot) {
          final hasData = snapshot.hasData;
          if (hasData) {
            final data = snapshot.data!;
            log(data.toString());
            // dev.log("snapshot " + snapshot.hasData.toString());
            // dev.log("data " + data.data.movies.toString());
            if (data.isEmpty) {
              return AlertDialog(
                title: const Text('Something is happening'),
                content: const Text(
                    'Cannot procceed your request. Please try again later.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => SystemChannels.platform
                        .invokeMethod('SystemNavigator.pop'),
                    child: const Text('Tutup'),
                  ),
                ],
              );
            } else {
              return ExploreMovie(movieWithDetail: data);
            }
          }
          return const CircularProgressIndicator();
        });
  }
}

class MovieWithDetail {
  MovieWithDetail({
    required this.status,
    required this.data,
  });
  late final String status;
  late final Data data;

  MovieWithDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.movies,
    required this.itemCount,
  });
  late final List<Movies> movies;
  late final int itemCount;

  Data.fromJson(Map<String, dynamic> json) {
    movies = List.from(json['movies']).map((e) => Movies.fromJson(e)).toList();
    itemCount = json['item_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['movies'] = movies.map((e) => e.toJson()).toList();
    _data['item_count'] = itemCount;
    return _data;
  }
}

class Movies {
  Movies({
    required this.id,
    required this.movieId,
    required this.title,
    required this.genres,
    required this.links,
    required this.movieDetail,
  });
  late final String id;
  late final String movieId;
  late final String title;
  late final String genres;
  late final List<Links> links;
  late final MovieDetail movieDetail;

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    movieId = json['movieId'];
    title = json['title'];
    genres = json['genres'];
    links = List.from(json['links']).map((e) => Links.fromJson(e)).toList();
    movieDetail = MovieDetail.fromJson(json['movie_detail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['movieId'] = movieId;
    _data['title'] = title;
    _data['genres'] = genres;
    _data['links'] = links.map((e) => e.toJson()).toList();
    _data['movie_detail'] = movieDetail.toJson();
    return _data;
  }
}

class Links {
  Links({
    required this.id,
    required this.movieId,
    required this.imdbId,
    required this.tmdbId,
  });
  late final String id;
  late final String movieId;
  late final String imdbId;
  late final String tmdbId;

  Links.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    movieId = json['movieId'];
    imdbId = json['imdbId'];
    tmdbId = json['tmdbId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['movieId'] = movieId;
    _data['imdbId'] = imdbId;
    _data['tmdbId'] = tmdbId;
    return _data;
  }
}

class MovieDetail {
  MovieDetail({
    required this.movieId,
    required this.tmbdbId,
    required this.imdbId,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
  });
  late final String movieId;
  late final String tmbdbId;
  late final String imdbId;
  late final String title;
  late final String originalTitle;
  late final String overview;
  late final String posterPath;

  MovieDetail.fromJson(Map<String, dynamic> json) {
    movieId = json['movie_id'];
    tmbdbId = json['tmbdb_id'];
    imdbId = json['imdb_id'];
    title = json['title'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['movie_id'] = movieId;
    _data['tmbdb_id'] = tmbdbId;
    _data['imdb_id'] = imdbId;
    _data['title'] = title;
    _data['original_title'] = originalTitle;
    _data['overview'] = overview;
    _data['poster_path'] = posterPath;
    return _data;
  }
}
