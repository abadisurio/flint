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
  });
  late final List<Movies> movies;

  Data.fromJson(Map<String, dynamic> json) {
    movies = List.from(json['movies']).map((e) => Movies.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['movies'] = movies.map((e) => e.toJson()).toList();
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
    _data['id'] = id;
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
    _data['id'] = id;
    _data['movieId'] = movieId;
    _data['imdbId'] = imdbId;
    _data['tmdbId'] = tmdbId;
    return _data;
  }
}

class MovieDetail {
  MovieDetail({
    required this.id,
    required this.imdbId,
    required this.title,
    required this.originalTitle,
    required this.posterPath,
  });
  late final int id;
  late final String imdbId;
  late final String title;
  late final String originalTitle;
  late final String posterPath;

  MovieDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imdbId = json['imdb_id'];
    title = json['title'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['imdb_id'] = imdbId;
    _data['title'] = title;
    _data['original_title'] = originalTitle;
    _data['poster_path'] = posterPath;
    return _data;
  }
}
