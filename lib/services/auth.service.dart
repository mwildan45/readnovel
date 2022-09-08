import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';
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


  static Future<void> setProfileValue(data) async {
    setValue(AppStrings.userId, data.id ?? "");
    setValue(AppStrings.firstName, data.firstname ?? "");
    setValue(AppStrings.lastName, data.lastname ?? "");
    setValue(AppStrings.username, data.username ?? "");
    setValue(AppStrings.userEmail, data.email ?? "");
    setValue(AppStrings.levelUser, data.level ?? "");
    setValue(AppStrings.coinUser, data.coin.toString());
    setValue(AppStrings.namaPena, data.namaPena ?? "");
    setValue(AppStrings.incomeUser, data.income ?? "");
    setValue(AppStrings.numberID, data.nomorID ?? "");
    setValue(AppStrings.phoneUser, data.telepon ?? "");
    setValue(AppStrings.facebook, data.facebook ?? "");
    // setValue(AppStrings.ageUser, data.umur ?? "");
  }


  static void logout(BuildContext context) async {
    await LocalStorageService.prefs?.clear();
    var pref = await getSharedPref();
    pref.clear();
    context.navigator?.pushNamedAndRemoveUntil(AppRoutes.splashScreenRoute, (route) => false);
  }
}
