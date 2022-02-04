import 'dart:convert';

import 'package:flint/model/movie_details.dart';
import 'package:flint/widget/explore_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as dev;
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

  // MovieWithDetail? filteredMovies;

  Future<MovieDetails> getFilteredMovie() async {
    //   // void getFilteredMovie() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   String? token = prefs.getString('authToken');
    //   dev.log("ini token lagi " + token.toString());

    //   // String token =
    //   //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjFmOTNlMjdlODg1NjAxMWIxNWZmMmMwIiwidXNlcm5hbWUiOiJhYmFkaXN1cmlvMyIsImlhdCI6MTY0Mzg1NTAwMiwiZXhwIjoxNjQ0NDU5ODAyfQ.Xw4If_vmGHn79SniiVHmOuo7FdY2ENJT1l3v5oEaHZM';
    //   String url = 'http://10.0.2.2:3000/api/getFilteredMoviesWithDetail';
    //   Map<String, String> requestHeaders = {
    //     'Content-type': 'application/json',
    //     'Accept': 'application/json',
    //     'Authorization': token ?? "hehe"
    //   };
    //   var client = http.Client();
    //   dev.log(requestHeaders.toString());
    //   dev.log("test");
    //   try {
    //     final response =
    //         await client.get(Uri.parse(url), headers: requestHeaders);
    //     dev.log(response.body);

    //     return MovieWithDetail.fromJson(jsonDecode(response.body));
    //   } catch (err) {
    //     dev.log(err.toString());
    return MovieDetails.fromJson({});
    //   } finally {
    //     client.close();
    //   }
  }

  void requestFilteredMovies() async {
    // final _filteredMovies = await getFilteredMovie();
    // setState(() {
    //   filteredMovies = _filteredMovies;
    // });
  }

  @override
  void initState() {
    super.initState();

    // dev.log("filteredMovies " + filteredMovies.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetails>(
        future: getFilteredMovie(),
        builder: (context, AsyncSnapshot<MovieDetails> snapshot) {
          final hasData = snapshot.hasData;
          if (hasData) {
            final data = snapshot.data!;
            // dev.log("snapshot " + snapshot.hasData.toString());
            // dev.log("data " + data.data.movies.toString());
            // if (data.data.movies.isEmpty) {
            //   return AlertDialog(
            //     title: const Text('Something is happening'),
            //     content: const Text(
            //         'Cannot procceed your request. Please try again later.'),
            //     actions: <Widget>[
            //       TextButton(
            //         onPressed: () => SystemChannels.platform
            //             .invokeMethod('SystemNavigator.pop'),
            //         child: const Text('Tutup'),
            //       ),
            //     ],
            //   );
            // } else {
            //   return ExploreMovie(movieWithDetail: data);
            // }
          }
          return const CircularProgressIndicator();
        });
  }
}
