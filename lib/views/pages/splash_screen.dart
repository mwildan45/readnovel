import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/view_models/splash_screen.vm.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key, this.link}) : super(key: key);
  final PendingDynamicLinkData? link;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
        viewModelBuilder: () => SplashScreenViewModel(context, link: link),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return SafeArea(
            child: Center(
              child: Image.asset(
                AppImages.appSplashScreenImage1,
                fit: BoxFit.fill,
                height: double.maxFinite,
                width: double.maxFinite,
              ),
            ),
          );
        });
  }
}
