import 'dart:async';

import 'package:flint/model/movie.dart';
import 'package:flint/model/movie_details.dart';
import 'package:flint/repository/movie_repository.dart';

class MovieBloc {
  final _movieRepository = MovieRepository();
  final _movieController = StreamController<List<MovieDetails>>.broadcast();

  get movies => _movieController.stream;

  MovieBloc() {
    getFilteredMovies();
  }

  void getFilteredMovies() async {
    _movieController.sink.add(await _movieRepository.getFilteredMovies());
  }
  // void getFilteredMovies({String? query}) async {
  //   // _movieController.sink
  //   //     .add(await _movieRepository.getAllMovies(query: query));
  // }

  addMovie(Movie movie) async {
    // await _movieRepository.insertMovie(movie);
    getFilteredMovies();
  }

  updateMovie(Movie movie) async {
    // await _movieRepository.updateMovie(movie);
    getFilteredMovies();
  }

  deleteMovieById(int id) async {
    // _movieRepository.deleteMovieById(id);
    getFilteredMovies();
  }

  dispose() {
    _movieController.close();
  }
}
