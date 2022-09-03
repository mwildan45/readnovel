class MyNovelDetail {
  int? id;
  String? title;
  String? cover;
  String? background;
  String? status;
  String? approval;
  int? chapter;
  List<String>? age;
  String? synopsis;
  List<String>? genre;

  MyNovelDetail(
      {this.id,
        this.title,
        this.cover,
        this.background,
        this.status,
        this.approval,
        this.chapter,
        this.age,
        this.synopsis,
        this.genre});

  MyNovelDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
    background = json['background'];
    status = json['status'];
    approval = json['approval'];
    chapter = json['chapter'];
    age = json['age'].cast<String>();
    synopsis = json['synopsis'];
    genre = json['genre'].cast<String>();
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
    return data;
  }
}