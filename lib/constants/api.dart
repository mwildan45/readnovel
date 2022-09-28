// import 'package:velocity_x/velocity_x.dart';


class Api {
  static String get baseUrl {
    // return "https://demo.higanic.com/api";
    return "https://manage.readnovel.id/api";
  }

  static String get baseDynamicLink {
    return 'https://readnovel.page.link';
    // return "https://manage.readnovel.id";
  }

  static String get baseProfilePictureUrl {
    // return "https://demo.higanic.com/public/image/profile/";
    return "https://manage.readnovel.id/public/image/profile/";
  }

  static const login = "/login";
  static const register = "/register";

  static const getBanner = "/banners";
  static const getListNovelsDashboard = "/novels_dashboard";
  static const getNovelDetail = "/detail_novel";
  static const getNovelChaptersList = "/chapter_list";
  static const getReadNovelChapter = "/read_chapter";
  static const getGenres = "/genres";
  static const getAges = "/ages";
  static const getNovelsPerSection = "/novels";
  static const getNovelsPerGenres = "/genrefilter";
  static const getSpecificNovel = "/find_specific_novel";
  static const searchNovel = "/search_novel";
  static const authors = "/authors";
  static const detailAuthor = "/detail_author";

  static const getBookmarks = "/bookmark";
  static const handleBookmark = "/isbookmark";
  static const getHistories = "/history";

  static const beAuthor = "/be_author";
  static const claimIncome = "/claim_income";

  static const createNovel = "/add_novel";
  static const updateNovel = "/edit_novel";
  static const myNovels = "/mynovels";
  static const myNovelDetail = "/mynoveldetail";
  static const myNovelChapters = "/my_novel_chapters";
  static const myNovelDetailChapter = "/my_detail_chapter";
  static const addChapter = "/add_chapter";
  static const editChapter = "/edit_chapter";

  static const getProfile = "/profile";
  static const updateProfile = "/update_profile";

  static const getFAQ = "/faq";
  static const getListAvailableCoinsTopUp = "/coins";
  static const buyCoin = "/buycoins";
  static const buyChapter = "/buy_chapter";

  // Other pages
  // static String get privacyPolicy {
  //   return "$webUrl/privacy/policy";
  // }


  // static Future<String> redirectAuth(String url) async {
  //   final userToken = await AuthServices.getAuthBearerToken();
  //   return "$webUrl/auth/redirect?token=$userToken&url=$url";
  // }
}
