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
  String? slug;
  String? approval;
  String? views;
  int? chapter;
  String? age;
  String? synopsis;
  bool? isBookmarked;
  List<String>? genre;
  List<Chapters>? chapters;

  DetailNovel(
      {this.id,
        this.title,
        this.cover,
        this.background,
        this.status,
        this.slug,
        this.synopsis,
        this.approval,
        this.views,
        this.chapter,
        this.age,
        this.genre,
        this.isBookmarked,
        this.chapters});

  DetailNovel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
    background = json['background'];
    status = json['status'];
    slug = json['slug'];
    approval = json['approval'];
    views = json['views'];
    chapter = json['chapter'];
    age = json['age'];
    synopsis = json['synopsis'];
    isBookmarked = json['isBookmarked'];
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
    data['slug'] = slug;
    data['approval'] = approval;
    data['views'] = views;
    data['chapter'] = chapter;
    data['age'] = age;
    data['synopsis'] = synopsis;
    data['genre'] = genre;
    data['isBookmarked'] = isBookmarked;
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
  bool? isLocked;

  Chapters({this.id, this.title, this.bab, this.coin, this.isLocked});

  Chapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bab = json['bab'];
    coin = json['coin'];
    isLocked = json['isLocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['bab'] = bab;
    data['coin'] = coin;
    data['isLocked'] = isLocked;
    return data;
  }
}
