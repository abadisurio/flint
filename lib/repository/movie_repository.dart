import 'package:flint/dao/movie_dao.dart';
import 'package:flint/model/movie.dart';

class MovieRepository {
  final movieDao = MovieDao();
  Future getFilteredMovies() => movieDao.getFilteredMovies();
  // Future getAllMovies({String? query}) => movieDao.getMovies(query: query);
  // Future insertMovie(Movie movie) => movieDao.createMovie(movie);
  // Future updateMovie(Movie movie) => movieDao.updateMovie(movie);
  // Future deleteMovieById(int id) => movieDao.deleteMovie(id);
  // Future deleteAllMovies() => movieDao.deleteAllMovies();
}
