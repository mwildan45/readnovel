class iPaymuResponse {
  int? status;
  bool? success;
  String? message;
  iPaymu? data;

  iPaymuResponse({this.status, this.success, this.message, this.data});

  iPaymuResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    success = json['Success'];
    message = json['Message'];
    data = json['Data'] != null ? iPaymu.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Success'] = success;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class iPaymu {
  String? sessionID;
  String? url;

  iPaymu({this.sessionID, this.url});

  iPaymu.fromJson(Map<String, dynamic> json) {
    sessionID = json['SessionID'];
    url = json['Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SessionID'] = sessionID;
    data['Url'] = url;
    return data;
  }
}
