class Movie {
  late int id;
  late String title;
  late String description;
  late int level;

  Movie({this.id = 0, this.title = "", this.description = "", this.level = 0});

  factory Movie.fromDatabaseJson(Map<String, dynamic> data) => Movie(
      id: data['id'], description: data['description'], level: data['level']);

  Map<String, dynamic> toDatabaseJson() => {
        "id": id,
        "title": title,
        "description": description,
        "level": level,
      };
}
