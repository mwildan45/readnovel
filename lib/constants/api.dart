// import 'package:velocity_x/velocity_x.dart';


class Api {
  static String get baseUrl {
    return "https://demo.higanic.com/api";
  }

  static const login = "/login";

  static const getBanner = "/banners";
  static const getListNovelsDashboard = "/novels_dashboard";
  static const getNovelDetail = "/detail_novel";
  static const getReadNovelChapter = "/read_chapter";
  static const getGenres = "/genres";

  // Other pages
  // static String get privacyPolicy {
  //   return "$webUrl/privacy/policy";
  // }


  // static Future<String> redirectAuth(String url) async {
  //   final userToken = await AuthServices.getAuthBearerToken();
  //   return "$webUrl/auth/redirect?token=$userToken&url=$url";
  // }
}
