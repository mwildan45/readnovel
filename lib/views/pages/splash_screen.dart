import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/view_models/splash_screen.vm.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
        viewModelBuilder: () => SplashScreenViewModel(context),
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
