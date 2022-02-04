import 'package:flint/model/movie.dart';

class EndpointFilteredMoviesWithDetail {
  EndpointFilteredMoviesWithDetail({
    required this.status,
    required this.data,
  });
  late final String status;
  late final Data data;

  EndpointFilteredMoviesWithDetail.fromJson(Map<String, dynamic> json) {
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
    required this.itemCount,
  });
  late final List<Movie> movies;
  late final int itemCount;

  Data.fromJson(Map<String, dynamic> json) {
    movies = List.from(json['movies']).map((e) => Movie.fromJson(e)).toList();
    itemCount = json['item_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['movies'] = movies.map((e) => e.toJson()).toList();
    _data['item_count'] = itemCount;
    return _data;
  }
}
