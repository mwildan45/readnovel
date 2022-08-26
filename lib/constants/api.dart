// import 'package:velocity_x/velocity_x.dart';


class Api {
  static String get baseUrl {
    return "https://demo.higanic.com/api";
  }

  static const login = "/login";
  static const register = "/register";

  static const getBanner = "/banners";
  static const getListNovelsDashboard = "/novels_dashboard";
  static const getNovelDetail = "/detail_novel";
  static const getReadNovelChapter = "/read_chapter";
  static const getGenres = "/genres";
  static const getAges = "/ages";

  static const getBookmarks = "/bookmark";
  static const handleBookmark = "/isbookmark";
  static const getHistories = "/history";

  static const getFAQ = "/faq";
  static const getCoinsTopUp = "/coins";

  // Other pages
  // static String get privacyPolicy {
  //   return "$webUrl/privacy/policy";
  // }


  // static Future<String> redirectAuth(String url) async {
  //   final userToken = await AuthServices.getAuthBearerToken();
  //   return "$webUrl/auth/redirect?token=$userToken&url=$url";
  // }
}
