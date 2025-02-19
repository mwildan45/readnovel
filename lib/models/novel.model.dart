class Novel {
  int? id;
  String? title;
  String? chapterTitle;
  String? cover;
  String? status;
  String? approval;
  String? author;
  String? sinopsis;
  String? sectionId;
  int? chapter;
  String? age;
  List<String>? genre;

  Novel(
      {this.id,
        this.title,
        this.chapterTitle,
        this.cover,
        this.status,
        this.approval,
        this.author,
        this.chapter,
        this.sinopsis,
        this.sectionId,
        this.age,
        this.genre});

  Novel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    chapterTitle = json['chapter_title'];
    cover = json['cover'];
    status = json['status'];
    approval = json['approval'];
    author = json['author'];
    chapter = json['chapter'];
    sinopsis = json['sinopsis'];
    sectionId = json['section_id'];
    age = json['age'];
    if (json['genre'] != null) {
      genre = json['genre'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['chapter_title'] = chapterTitle;
    data['cover'] = cover;
    data['status'] = status;
    data['approval'] = approval;
    data['author'] = author;
    data['chapter'] = chapter;
    data['sinopsis'] = sinopsis;
    data['section_id'] = sectionId;
    data['age'] = age;
    if (genre != null) {
      data['genre'] = genre;
    }
    return data;
  }
}
