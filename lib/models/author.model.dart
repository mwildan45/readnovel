class Author {
  int? id;
  String? namaPena;
  String? profile;

  Author({this.id, this.namaPena, this.profile});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPena = json['nama_pena'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama_pena'] = namaPena;
    data['profile'] = profile;
    return data;
  }
}