class MovieLevels {
  MovieLevels({
    required this.status,
    required this.data,
  });
  late final String status;
  late final Data data;

  MovieLevels.fromJson(Map<String, dynamic> json) {
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
    required this.lastId,
    required this.isLast,
  });
  late final List<Movies> movies;
  late final String lastId;
  late final bool isLast;

  Data.fromJson(Map<String, dynamic> json) {
    movies = List.from(json['movies']).map((e) => Movies.fromJson(e)).toList();
    lastId = json['lastId'];
    isLast = json['isLast'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['movies'] = movies.map((e) => e.toJson()).toList();
    _data['lastId'] = lastId;
    _data['isLast'] = isLast;
    return _data;
  }
}

class Movies {
  Movies({
    required this.id,
    required this.userId,
    required this.movieId,
    required this.level,
    required this.V,
  });
  late final String id;
  late final String userId;
  late final String movieId;
  late final String level;
  late final int V;

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    movieId = json['movieId'];
    level = json['level'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['movieId'] = movieId;
    _data['level'] = level;
    _data['__v'] = V;
    return _data;
  }
}
