class HeaderCoinsTopUp {
  String? message;
  List<CoinsTopUp>? data;

  HeaderCoinsTopUp({this.message, this.data});

  HeaderCoinsTopUp.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <CoinsTopUp>[];
      json['data'].forEach((v) {
        data!.add(CoinsTopUp.fromJson(v));
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

class CoinsTopUp {
  int? id;
  String? name;
  int? price;
  String? createdAt;
  String? updatedAt;

  CoinsTopUp({this.id, this.name, this.price, this.createdAt, this.updatedAt});

  CoinsTopUp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
