class MovieDetails {
  MovieDetails({
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

  MovieDetails.fromJson(Map<String, dynamic> json) {
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
