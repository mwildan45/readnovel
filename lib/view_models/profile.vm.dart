import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/faq.model.dart';
import 'package:read_novel/requests/profile.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileViewModel extends MyBaseViewModel {
  ProfileViewModel(BuildContext context){
    viewContext = context;
  }

  ProfileRequest profileRequest = ProfileRequest();
  List<FAQ>? faq;


  @override
  void initialise() {

  }

  //
  getFAQData() async {

    setBusyForObject(faq, true);

    try {
      faq = await profileRequest.getFAQ();

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    setBusyForObject(faq, false);
  }

  navPusatBantuanPage(){
    viewContext?.navigator?.pushNamed(AppRoutes.faqRoute);
  }


  navKoinkuPage(){
    viewContext?.navigator?.pushNamed(AppRoutes.koinkuRoute);
  }

  onLoginPage() {
    viewContext?.navigator?.pushNamed(AppRoutes.loginRoute);
  }

  processLogout() async {
    AuthServices.logout(viewContext!);
  }
}