class Cast {
  List<Actor> actores = [];

  Cast.formJsonList(List<dynamic> jsonList) {
    jsonList.forEach((item) {
      final actor = Actor.formJsonMap(item);

      actores.add(actor);
    });
  }
}

class Actor {
  int? gender;
  int? id;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  int? order;

  Actor({
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.order,
  });

  Actor.formJsonMap(Map<String, dynamic> json) {
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    order = json['order'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'https://www.slotcharter.net/wp-content/uploads/2020/02/no-avatar.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
