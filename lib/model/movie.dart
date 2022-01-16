class Movie {
  late int id;
  late String title;
  late String posterURL;
  late String genre;
  late int level;

  Movie(
      {this.id = 0,
      this.title = "",
      this.posterURL = "",
      this.genre = "",
      this.level = 0});

  factory Movie.fromDatabaseJson(Map<String, dynamic> data) => Movie(
      id: data['id'],
      title: data['title'],
      posterURL: data['posterURL'],
      genre: data['genre'],
      level: data['level']);

  Map<String, dynamic> toDatabaseJson() => {
        "id": id,
        "title": title,
        "posterURL": posterURL,
        "genre": genre,
        "level": level,
      };
}
