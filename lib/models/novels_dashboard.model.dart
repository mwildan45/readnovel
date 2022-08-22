import 'package:read_novel/models/novel.model.dart';

class HeaderListNovelOnDashboard {
  String? message;
  ListNovelsDashboard? data;

  HeaderListNovelOnDashboard({this.message, this.data});

  HeaderListNovelOnDashboard.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? ListNovelsDashboard.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ListNovelsDashboard {
  List<Novel>? novelPopuler;
  List<Novel>? wajibDibaca;
  List<Novel>? novelDisukai;
  List<Novel>? bukuBaru;
  List<Novel>? rekomendasi;
  List<Novel>? mungkinSuka;

  ListNovelsDashboard(
      {this.novelPopuler,
      this.wajibDibaca,
      this.novelDisukai,
      this.bukuBaru,
      this.rekomendasi,
      this.mungkinSuka});

  ListNovelsDashboard.fromJson(Map<String, dynamic> json) {
    if (json['novel_populer'] != null) {
      novelPopuler = <Novel>[];
      json['novel_populer'].forEach((v) {
        novelPopuler!.add(Novel.fromJson(v));
      });
    }
    if (json['wajib_dibaca'] != null) {
      wajibDibaca = <Novel>[];
      json['wajib_dibaca'].forEach((v) {
        wajibDibaca!.add(Novel.fromJson(v));
      });
    }
    if (json['novel_disukai'] != null) {
      novelDisukai = <Novel>[];
      json['novel_disukai'].forEach((v) {
        novelDisukai!.add(Novel.fromJson(v));
      });
    }
    if (json['buku_baru'] != null) {
      bukuBaru = <Novel>[];
      json['buku_baru'].forEach((v) {
        bukuBaru!.add(Novel.fromJson(v));
      });
    }
    if (json['rekomendasi'] != null) {
      rekomendasi = <Novel>[];
      json['rekomendasi'].forEach((v) {
        rekomendasi!.add(Novel.fromJson(v));
      });
    }
    if (json['mungkin_suka'] != null) {
      mungkinSuka = <Novel>[];
      json['mungkin_suka'].forEach((v) {
        mungkinSuka!.add(Novel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (novelPopuler != null) {
      data['novel_populer'] =
          novelPopuler!.map((v) => v.toJson()).toList();
    }
    if (wajibDibaca != null) {
      data['wajib_dibaca'] = wajibDibaca!.map((v) => v.toJson()).toList();
    }
    if (novelDisukai != null) {
      data['novel_disukai'] =
          novelDisukai!.map((v) => v.toJson()).toList();
    }
    if (bukuBaru != null) {
      data['buku_baru'] = bukuBaru!.map((v) => v.toJson()).toList();
    }
    if (rekomendasi != null) {
      data['rekomendasi'] = rekomendasi!.map((v) => v.toJson()).toList();
    }
    if (mungkinSuka != null) {
      data['mungkin_suka'] = mungkinSuka!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
