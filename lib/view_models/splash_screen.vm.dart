import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/requests/novel_detail.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/services/notification_services.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreenViewModel extends MyBaseViewModel {
  SplashScreenViewModel(BuildContext context, {this.link}) {
    viewContext = context;
  }

  PendingDynamicLinkData? link;
  NovelDetailRequest novelDetailRequest = NovelDetailRequest();

  @override
  void initialise() {
    if(link != null){
      handleDeepLink();
    }else{
      handleNextPage();
    }
    handleNotifications();
  }

  //
  handleNextPage() {
    print('is authenticate ${AuthServices.authenticated()}');
    Future.delayed(const Duration(seconds: 1), () {
      if (!AuthServices.authenticated()) {
        viewContext?.navigator?.pushNamedAndRemoveUntil(AppRoutes.loginRoute, (route) => false);
      } else {
        viewContext?.navigator?.pushNamedAndRemoveUntil(AppRoutes.homeRoute, (route) => false);
      }
    });
  }

  //
  handleDeepLink() async {
    final Uri? deepLink = link?.link;

    if (deepLink != null) {
      print("LINK ${deepLink.queryParameters['id']}");
      final id = deepLink.queryParameters['id'];
      Future.delayed(const Duration(seconds: 1), () {
        if (!AuthServices.authenticated()) {
          viewContext?.navigator?.pushNamedAndRemoveUntil(
              AppRoutes.loginRoute, (route) => false);
        } else {
          novelDetailRequest.getSpecificNovel(id ?? "5").then((value) {
            viewContext?.navigator?.pushNamedAndRemoveUntil(
                AppRoutes.homeRoute, (route) => false);
            viewContext?.navigator?.pushNamed(
              AppRoutes.detailNovelRoute,
              arguments: value,
            );
          });
        }
      });
    }
  }

  handleNotifications() async {
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('data notif ${result.notification.additionalData}');
      final id = result.notification.additionalData?['novel_id'].toString();
      NotificationService().handleOpenNovel(viewContext!, id);
      // Will be called whenever a notification is opened/button pressed.
    });
  }
}
