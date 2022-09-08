class HeaderLogin {
  String? status;
  Login? data;

  HeaderLogin({this.status, this.data});

  HeaderLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Login.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Login {
  int? id;
  String? name;
  String? username;
  String? email;
  String? emailVerifiedAt;
  String? password;
  String? rememberToken;
  String? firstname;
  String? lastname;
  String? profile;
  String? accesstoken;
  String? logintype;
  int? level;
  dynamic coin;
  String? namaPena;
  dynamic income;
  String? nomorID;
  String? telepon;
  String? facebook;
  String? umur;
  String? createdAt;
  String? updatedAt;

  Login(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.emailVerifiedAt,
        this.password,
        this.rememberToken,
        this.firstname,
        this.lastname,
        this.profile,
        this.accesstoken,
        this.logintype,
        this.level,
        this.coin,
        this.namaPena,
        this.income,
        this.nomorID,
        this.telepon,
        this.facebook,
        this.umur,
        this.createdAt,
        this.updatedAt});

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    rememberToken = json['remember_token'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    profile = json['profile'];
    accesstoken = json['accesstoken'];
    logintype = json['logintype'];
    level = json['level'];
    coin = json['coin'];
    namaPena = json['nama_pena'];
    income = json['income'];
    nomorID = json['nomorID'];
    telepon = json['telepon'];
    facebook = json['facebook'];
    umur = json['umur'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['password'] = password;
    data['remember_token'] = rememberToken;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['profile'] = profile;
    data['accesstoken'] = accesstoken;
    data['logintype'] = logintype;
    data['level'] = level;
    data['coin'] = coin;
    data['nama_pena'] = namaPena;
    data['income'] = income;
    data['nomorID'] = nomorID;
    data['telepon'] = telepon;
    data['facebook'] = facebook;
    data['umur'] = umur;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
