import 'dart:convert';


import 'package:read_novel/constants/app_strings.dart';
// import 'package:read_novel/models/user.dart';

import 'http.service.dart';
import 'local_storage.service.dart';

class AuthServices {
  //
  // static bool firstTimeOnApp() {
  //   return LocalStorageService.prefs.getBool(AppStrings.firstTimeOnApp) ?? true;
  // }
  //
  // static firstTimeCompleted() async {
  //   await LocalStorageService.prefs.setBool(AppStrings.firstTimeOnApp, false);
  // }
  //
  // //
  static bool authenticated() {
    return LocalStorageService.prefs?.getBool(AppStrings.authenticated) ?? false;
  }
  //
  static Future<bool>? isAuthenticated() {
    return LocalStorageService.prefs?.setBool(AppStrings.authenticated, true);
  }

  // Token
  static Future<String> getAuthBearerToken() async {
    return LocalStorageService.prefs?.getString(AppStrings.userAuthToken) ?? "";
  }

  static Future<bool?> setAuthBearerToken(token) async {
    return LocalStorageService.prefs?.setString(AppStrings.userAuthToken, token);
  }

//   //Locale
//   static String getLocale() {
//     return LocalStorageService.prefs.getString(AppStrings.appLocale) ?? "id";
//   }
//
//   static Future<bool> setLocale(language) async {
//     return LocalStorageService.prefs.setString(AppStrings.appLocale, language);
//   }
//
//   //
//   //
//   static User? currentUser;
//   static Future<User?> getCurrentUser({bool force = false}) async {
//     if (currentUser == null || force) {
//       final userStringObject =
//           await LocalStorageService.prefs?.getString(AppStrings.userKey);
//       final userObject = json.decode(userStringObject!);
//       currentUser = User.fromJson(userObject);
//     }
//
//     return currentUser;
//   }
//
// //

  // static Future<User?> saveUser(dynamic jsonObject) async {
  //   final currentUser = User.fromJson(jsonObject);
  //   try {
  //     await LocalStorageService.prefs?.setString(
  //       AppStrings.userKey,
  //       json.encode(
  //         currentUser.toJson(),
  //       ),
  //     );
  //
  //     return currentUser;
  //   } catch (error) {
  //     return null;
  //   }
  // }

//
//   static void logout() async {
//     await HttpService().getCacheManager().clearAll();
//     await LocalStorageService.prefs.clear();
//     await LocalStorageService.prefs.setBool(AppStrings.firstTimeOnApp, false);
//     FirebaseService()
//         .firebaseMessaging
//         .unsubscribeFromTopic("v_${currentUser.vendor_id}");
//     FirebaseService()
//         .firebaseMessaging
//         .unsubscribeFromTopic("${currentUser.role}");
//   }
}
