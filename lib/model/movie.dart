// class Movie {
//   late int id;
//   late String title;
//   late String posterURL;
//   late String genre;
//   late int level;

//   Movie(
//       {this.id = 0,
//       this.title = "",
//       this.posterURL = "",
//       this.genre = "",
//       this.level = 0});

//   factory Movie.fromDatabaseJson(Map<String, dynamic> data) => Movie(
//       id: data['id'],
//       title: data['title'],
//       posterURL: data['posterURL'],
//       genre: data['genre'],
//       level: data['level']);

//   Map<String, dynamic> toDatabaseJson() => {
//         "id": id,
//         "title": title,
//         "posterURL": posterURL,
//         "genre": genre,
//         "level": level,
//       };
// }

import 'package:flint/model/movie_details.dart';
import 'package:flint/model/movie_links.dart';

class Movie {
  Movie({
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
  late final List<MovieLinks> links;
  late final MovieDetails movieDetail;

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    movieId = json['movieId'];
    title = json['title'];
    genres = json['genres'];
    links =
        List.from(json['links']).map((e) => MovieLinks.fromJson(e)).toList();
    movieDetail = MovieDetails.fromJson(json['movie_detail']);
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
