import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/requests/novel_detail.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/utils/GlobalVariable.dart';
import 'package:read_novel/views/pages/splash_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationService {
  handleOpenNovel(BuildContext context, String? id) {
    NovelDetailRequest novelDetailRequest = NovelDetailRequest();
    if (!AuthServices.authenticated()) {
      Navigator.of(GlobalVariable.navState.currentContext!).push(MaterialPageRoute(builder: (context) => const SplashScreen()));
    } else {
      novelDetailRequest.getSpecificNovel(id ?? "5").then((value) {
        GlobalVariable.navState.currentContext?.navigator?.pushNamedAndRemoveUntil(AppRoutes.homeRoute, (route) => false);
        GlobalVariable.navState.currentContext?.navigator?.pushNamed(
          AppRoutes.detailNovelRoute,
          arguments: value,
        );
      });
    }
  }
}