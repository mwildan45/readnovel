class HeaderDetailNovel {
  String? messege;
  DetailNovel? data;

  HeaderDetailNovel({this.messege, this.data});

  HeaderDetailNovel.fromJson(Map<String, dynamic> json) {
    messege = json['messege'];
    data = json['data'] != null ? DetailNovel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messege'] = messege;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DetailNovel {
  int? id;
  String? title;
  String? cover;
  String? background;
  String? status;
  String? approval;
  int? chapter;
  String? age;
  String? synopsis;
  List<String>? genre;
  List<Chapters>? chapters;

  DetailNovel(
      {this.id,
        this.title,
        this.cover,
        this.background,
        this.status,
        this.approval,
        this.chapter,
        this.age,
        this.genre,
        this.chapters});

  DetailNovel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
    background = json['background'];
    status = json['status'];
    approval = json['approval'];
    chapter = json['chapter'];
    age = json['age'];
    synopsis = json['synopsis'];
    genre = json['genre'].cast<String>();
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['cover'] = cover;
    data['background'] = background;
    data['status'] = status;
    data['approval'] = approval;
    data['chapter'] = chapter;
    data['age'] = age;
    data['synopsis'] = synopsis;
    data['genre'] = genre;
    if (chapters != null) {
      data['chapters'] = chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapters {
  int? id;
  String? title;
  int? bab;
  int? coin;

  Chapters({this.id, this.title, this.bab, this.coin});

  Chapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bab = json['bab'];
    coin = json['coin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['bab'] = bab;
    data['coin'] = coin;
    return data;
  }
}
