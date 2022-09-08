import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/requests/dashboard.request.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class SeeAllViewModel extends MyBaseViewModel {
  SeeAllViewModel(BuildContext context, this.sectionName){
    viewContext = context;
  }

  String sectionName;
  String pageTitle = "title";
  DashboardRequest dashboardRequest = DashboardRequest();
  List<Novel>? novels;

  @override
  void initialise() {
    handleTitle();
    fetchSeeAllNovelsPerSection();
  }

  //
  handleTitle() {
    if(sectionName == AppStrings.popular){
      pageTitle = 'Buku Populer';
    }else if(sectionName == AppStrings.wajib){
      pageTitle = 'Wajib Dibaca';
    }else if(sectionName == AppStrings.disukai){
      pageTitle = 'Disukai';
    }else if(sectionName == AppStrings.baru){
      pageTitle = 'Buku Baru Pilihan';
    }else if(sectionName == AppStrings.pilihan){
      pageTitle = 'Rekomendasi Pilihan';
    }else if(sectionName == AppStrings.rekomendasi){
      pageTitle = 'Kamu Mungkin Suka';
    }
  }

  fetchSeeAllNovelsPerSection() async {
    setBusy(true);

    try {

      novels = await dashboardRequest.getNovelsPerSection(sectionName);

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
      // viewContext?.showToast(
      //   msg: "$error",
      //   bgColor: Colors.red,
      // );
    }

    setBusy(false);
  }

  onBackPressed() {
    //
    viewContext?.navigator?.pop(true);
  }

  openNovel(int? id, Novel? novel) async {
    final result = await viewContext?.navigator?.pushNamed(
      AppRoutes.detailNovelRoute,
      arguments: novel,
    );
  }

}