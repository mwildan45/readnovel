class Chapter {
  int? id;
  String? title;
  int? bab;
  int? coin;
  String? status;

  Chapter({this.id, this.title, this.bab, this.coin, this.status});

  Chapter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bab = json['bab'];
    coin = json['coin'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['bab'] = bab;
    data['coin'] = coin;
    data['status'] = status;
    return data;
  }
}