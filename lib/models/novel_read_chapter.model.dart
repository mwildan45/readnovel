class HeaderReadNovelChapter {
  String? messege;
  Read? data;

  HeaderReadNovelChapter({this.messege, this.data});

  HeaderReadNovelChapter.fromJson(Map<String, dynamic> json) {
    messege = json['messege'];
    data = json['data'] != null ? Read.fromJson(json['data']) : null;
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

class Read {
  int? id;
  String? title;
  String? slug;
  int? coin;
  int? bab;
  String? status;
  String? content;
  int? novelId;
  String? createdAt;
  String? updatedAt;

  Read(
      {this.id,
        this.title,
        this.slug,
        this.coin,
        this.bab,
        this.status,
        this.content,
        this.novelId,
        this.createdAt,
        this.updatedAt});

  Read.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    coin = json['coin'];
    bab = json['bab'];
    status = json['status'];
    content = json['content'];
    novelId = json['novel_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['coin'] = coin;
    data['bab'] = bab;
    data['status'] = status;
    data['content'] = content;
    data['novel_id'] = novelId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
