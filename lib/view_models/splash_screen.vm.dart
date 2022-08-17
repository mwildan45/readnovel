import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_routes.dart';
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
    Future.delayed(const Duration(seconds: 3), () {
      viewContext?.navigator?.pushNamed(AppRoutes.homeRoute);
    });
  }
}
