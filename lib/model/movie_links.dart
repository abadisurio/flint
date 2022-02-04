class MovieLinks {
  MovieLinks({
    required this.id,
    required this.movieId,
    required this.imdbId,
    required this.tmdbId,
  });
  late final String id;
  late final String movieId;
  late final String imdbId;
  late final String tmdbId;

  MovieLinks.fromJson(Map<String, dynamic> json) {
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
