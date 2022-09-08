import 'dart:convert';

import 'package:read_novel/services/local_storage.service.dart';

class AppStrings {
  static String get appName => "ReadNovel";

  static String get appCurrency => "Rp ";

  static String userAuthToken = "auth_token";
  static String userKey = "user";
  static String authenticated = "authenticated";
  static String profileImg = "profile_image";
  static String isSocialLogin = "is_social_login";
  static String loginType = "login_type";
  static String userId = "user_id";
  static String firstName = "first_name";
  static String lastName = "last_name";
  static String userEmail = "user_email";
  static String username = "username";
  static String levelUser = "level_user";
  static String coinUser = "coin_user";
  static String namaPena = "nama_pena";
  static String incomeUser = "income_user";
  static String numberID = "number_id_user";
  static String phoneUser = "phone_user";
  static String facebook = "facebook_user";
  static String ageUser = "age_user";

  static List<String> listTabLabelDashboard = ['Home', 'Genres'];
  static List<String> listTabLabelLibrary = ['Terakhir Dibaca', 'Bookmark'];
  static List<String> listTabLabelMenulis = ['Rilis', 'Draft'];

  static String popular = "populer";
  static String wajib = "wajib";
  static String disukai = "disukai";
  static String baru = "baru";
  static String rekomendasi = "rekomendasi";
  static String pilihan = "pilihan";

}

enum SectionName {
  popular, mustRead, mostlyLiked, newNovel, recommended, editorChoices
}

extension SectionNameExtension on SectionName {

  String? get name {
    switch (this) {
      case SectionName.popular:
        return 'populer';
      case SectionName.mustRead:
        return 'wajib';
      case SectionName.mostlyLiked:
        return 'disukai';
      case SectionName.newNovel:
        return 'baru';
      case SectionName.recommended:
        return 'rekomendasi';
      case SectionName.editorChoices:
        return 'pilihan';
      default:
        return null;
    }
  }
}