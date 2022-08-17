class BannerHeader {
  String? message;
  List<BannerData>? data;

  BannerHeader({this.message, this.data});

  BannerHeader.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data!.add(new BannerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerData {
  String? img;
  String? url;

  BannerData({this.img, this.url});

  BannerData.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['url'] = this.url;
    return data;
  }
}
