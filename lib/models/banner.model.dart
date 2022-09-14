class BannerHeader {
  String? message;
  List<BannerData>? data;

  BannerHeader({this.message, this.data});

  BannerHeader.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data!.add(BannerData.fromJson(v));
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

class BannerData {
  String? img;
  int? novelId;

  BannerData({this.img, this.novelId});

  BannerData.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    novelId = json['novel_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img'] = img;
    data['novel_id'] = novelId;
    return data;
  }
}
