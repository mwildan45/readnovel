class Novel {
  int? id;
  String? title;
  String? cover;
  String? status;
  String? approval;
  int? chapter;
  String? age;
  List<String>? genre;

  Novel(
      {this.id,
        this.title,
        this.cover,
        this.status,
        this.approval,
        this.chapter,
        this.age,
        this.genre});

  Novel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
    status = json['status'];
    approval = json['approval'];
    chapter = json['chapter'];
    age = json['age'];
    genre = json['genre'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['cover'] = cover;
    data['status'] = status;
    data['approval'] = approval;
    data['chapter'] = chapter;
    data['age'] = age;
    data['genre'] = genre;
    return data;
  }
}
