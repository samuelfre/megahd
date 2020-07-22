class MovieModel {
  int id;
  List<Results> results;

  MovieModel({this.id, this.results});

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String key;
  String name;
  String site;

  Results({this.key, this.name, this.site});

  Results.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    site = json['site'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['site'] = this.site;
    return data;
  }
}
