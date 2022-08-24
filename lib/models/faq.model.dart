class HeaderFAQ {
  String? message;
  List<FAQ>? data;

  HeaderFAQ({this.message, this.data});

  HeaderFAQ.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <FAQ>[];
      json['data'].forEach((v) {
        data!.add(FAQ.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FAQ {
  int? id;
  String? title;
  String? slug;
  String? content;
  String? createdAt;
  String? updatedAt;

  FAQ(
      {this.id,
        this.title,
        this.slug,
        this.content,
        this.createdAt,
        this.updatedAt});

  FAQ.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
