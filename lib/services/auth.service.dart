import 'dart:convert';


import 'package:read_novel/constants/app_strings.dart';
// import 'package:read_novel/models/user.dart';

import 'http.service.dart';
import 'local_storage.service.dart';

class AuthServices {

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

}
