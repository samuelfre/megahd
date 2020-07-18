class Credits {
  List<Cast> cast;

  Credits({this.cast});

  Credits.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      cast = new List<Cast>();
      json['cast'].forEach((v) {
        cast.add(new Cast.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cast != null) {
      data['cast'] = this.cast.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cast {
  String character;
  String name;
  String profilePath;

  Cast({this.character, this.name, this.profilePath});

  Cast.fromJson(Map<String, dynamic> json) {
    character = json['character'];
    name = json['name'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['character'] = this.character;
    data['name'] = this.name;
    data['profile_path'] = this.profilePath;
    return data;
  }
}