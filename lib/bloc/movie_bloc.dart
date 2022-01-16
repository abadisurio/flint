import 'dart:async';

import 'package:flint/model/movie.dart';
import 'package:flint/repository/movie_repository.dart';

class MovieBloc {
  final _movieRepository = MovieRepository();
  final _movieController = StreamController<List<Movie>>.broadcast();

  get movies => _movieController.stream;

  MovieBloc() {
    getMovies();
  }

  void getMovies({String? query}) async {
    _movieController.sink
        .add(await _movieRepository.getAllMovies(query: query));
  }

  addMovie(Movie movie) async {
    await _movieRepository.insertMovie(movie);
    getMovies();
  }

  updateMovie(Movie movie) async {
    await _movieRepository.updateMovie(movie);
    getMovies();
  }

  deleteMovieById(int id) async {
    _movieRepository.deleteMovieById(id);
    getMovies();
  }

  dispose() {
    _movieController.close();
  }
}
