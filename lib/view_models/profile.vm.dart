import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileViewModel extends MyBaseViewModel {
  ProfileViewModel(BuildContext context){
    viewContext = context;
  }

  onLoginPage() {
    viewContext?.navigator?.pushNamed(AppRoutes.loginRoute);
  }
}