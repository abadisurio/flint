import 'package:flint/model/movie_details.dart';
import 'package:flint/widget/explore_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flint/bloc/movie_bloc.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({Key? key}) : super(key: key);
  final MovieBloc movieBloc = MovieBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MovieDetails>>(
        stream: movieBloc.movies,
        builder: (context, AsyncSnapshot<List<MovieDetails>> snapshot) {
          final hasData = snapshot.hasData;
          if (hasData) {
            final data = snapshot.data!;
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
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
