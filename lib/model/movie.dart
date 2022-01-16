class Movie {
  late int id;
  late String title;
  late String genre;
  late int level;

  Movie({this.id = 0, this.title = "", this.genre = "", this.level = 0});

  factory Movie.fromDatabaseJson(Map<String, dynamic> data) =>
      Movie(id: data['id'], title: data['title'], genre: data['genre'], level: data['level']);

  Map<String, dynamic> toDatabaseJson() => {
        "id": id,
        "title": title,
        "genre": genre,
        "level": level,
      };
}
