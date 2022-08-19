import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreenViewModel extends MyBaseViewModel {
  SplashScreenViewModel(BuildContext context) {
    viewContext = context;
  }

  @override
  void initialise() {
    handleNextPage();
  }

  handleNextPage() {
    print('is authenticate ${AuthServices.authenticated()}');
    Future.delayed(const Duration(seconds: 2), () {
      if (!AuthServices.authenticated()) {
        viewContext?.navigator?.pushNamedAndRemoveUntil(AppRoutes.loginRoute, (route) => false);
      } else {
        viewContext?.navigator?.pushNamedAndRemoveUntil(AppRoutes.homeRoute, (route) => false);
      }
    });
  }
}
