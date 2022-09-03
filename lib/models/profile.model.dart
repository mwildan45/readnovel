class Profile {
  int? id;
  String? name;
  String? username;
  String? email;
  String? firstname;
  String? lastname;
  String? profile;
  int? level;
  String? alamat;
  String? tanggalLahir;
  dynamic coin;
  dynamic income;
  String? facebook;
  String? telepon;
  String? namabank;
  String? atasnama;
  String? rekening;
  String? nomorID;
  String? imageId;

  Profile(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.firstname,
        this.lastname,
        this.profile,
        this.level,
        this.alamat,
        this.tanggalLahir,
        this.coin,
        this.income,
        this.facebook,
        this.telepon,
        this.namabank,
        this.atasnama,
        this.rekening,
        this.nomorID,
        this.imageId});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    profile = json['profile'];
    level = json['level'];
    alamat = json['alamat'];
    tanggalLahir = json['tanggal_lahir'];
    coin = json['coin'];
    income = json['income'];
    facebook = json['facebook'];
    telepon = json['telepon'];
    namabank = json['namabank'];
    atasnama = json['atasnama'];
    rekening = json['rekening'];
    nomorID = json['nomor_id'];
    imageId = json['image_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['profile'] = profile;
    data['level'] = level;
    data['alamat'] = alamat;
    data['tanggal_lahir'] = tanggalLahir;
    data['coin'] = coin;
    data['income'] = income;
    data['facebook'] = facebook;
    data['telepon'] = telepon;
    data['namabank'] = namabank;
    data['atasnama'] = atasnama;
    data['rekening'] = rekening;
    data['nomor_id'] = nomorID;
    data['image_id'] = imageId;
    return data;
  }
}