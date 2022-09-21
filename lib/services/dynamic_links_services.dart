import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/constants/api.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/requests/novel_detail.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/utils/GlobalVariable.dart';
import 'package:read_novel/views/pages/splash_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class DynamicLinkService {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<Uri> createDynamicLink(int id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: Api.baseDynamicLink,
      link: Uri.parse("${Api.baseDynamicLink}/?id=$id"),
      androidParameters: const AndroidParameters(
        packageName: 'com.readnovel.read_novel',
        minimumVersion: 1,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'your_ios_bundle_identifier',
        minimumVersion: '1',
        // appStoreId: 'your_app_store_id',
      ),
    );

    Uri url;
    final ShortDynamicLink shortLink =
      await dynamicLinks.buildShortLink(parameters, shortLinkType: ShortDynamicLinkType.unguessable,);
    url = shortLink.shortUrl;

    return url;
  }

  Future<void> retrieveDynamicLink(BuildContext context) async {
    NovelDetailRequest novelDetailRequest = NovelDetailRequest();

    try {
      final PendingDynamicLinkData? data = await dynamicLinks.getInitialLink();
      final Uri? deepLink = data?.link;

      // if (deepLink != null) {
      //   print("LINK ${deepLink.queryParameters['id']}");
      //   final id = deepLink.queryParameters['id'];
      //   if (!AuthServices.authenticated()) {
      //     context.navigator?.pushNamedAndRemoveUntil(AppRoutes.loginRoute, (route) => false);
      //   } else {
      //     novelDetailRequest.getSpecificNovel(id ?? "5").then((value) {
      //       context.navigator?.pushNamedAndRemoveUntil(AppRoutes.homeRoute, (route) => false);
      //       context.navigator?.pushNamed(
      //         AppRoutes.detailNovelRoute,
      //         arguments: value,
      //       );
      //     });
      //   }
      // }

      dynamicLinks.onLink.listen((PendingDynamicLinkData dynamicLink) async {
        print("LINK 2 ${dynamicLink.link.queryParameters['id']}");
        final id = dynamicLink.link.queryParameters['id'];
        if (!AuthServices.authenticated()) {
          Navigator.of(GlobalVariable.navState.currentContext ?? context).push(MaterialPageRoute(builder: (context) => const SplashScreen()));
        } else {
          novelDetailRequest.getSpecificNovel(id ?? "5").then((value) {
            GlobalVariable.navState.currentContext?.navigator?.pushNamedAndRemoveUntil(AppRoutes.homeRoute, (route) => false);
            GlobalVariable.navState.currentContext?.navigator?.pushNamed(
              AppRoutes.detailNovelRoute,
              arguments: value,
            );
          });
        }
        // context.navigator?.pushNamedAndRemoveUntil(AppRoutes.homeRoute, (route) => false);
      });

    } catch (e) {
      print(e.toString());
    }
  }
}
