import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/banner.model.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/models/novels_dashboard.model.dart';
import 'package:read_novel/requests/dashboard.request.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class DashboardViewModel extends MyBaseViewModel {
  DashboardViewModel(BuildContext context) {
    viewContext = context;
  }

  DashboardRequest dashboardRequest = DashboardRequest();
  int currentSliderIndex = 0;
  final CarouselController carouselController = CarouselController();
  BannerHeader? bannerData;
  ListNovelsDashboard? data;
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initialise() {
    fetchBanner();
    fetchListNovelsDashboard();
  }

  void onRefresh() async{
    fetchBanner();
    fetchListNovelsDashboard();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  onSliderChanged(index, reason) {
    currentSliderIndex = index;
    notifyListeners();
  }

  //
  fetchBanner() async {
    setBusyForObject(bannerData, true);
    try {

      bannerData = await dashboardRequest.getBanners();

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
      // viewContext?.showToast(
      //   msg: "$error",
      //   bgColor: Colors.red,
      // );
    }

    setBusyForObject(bannerData, false);
  }

  //
  fetchListNovelsDashboard() async {
    setBusy(true);
    try {

      data = await dashboardRequest.getNovelsDashboard();

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

  openNovel(int? id, Novel? novel) async {
    final result = await viewContext?.navigator?.pushNamed(
      AppRoutes.detailNovelRoute,
      arguments: novel,
    );

    if (result != null && result is Novel) {
      print('back 1');
      final orderIndex = data?.novelPopuler?.indexWhere((e) => e.id == result.id);
      data?.novelPopuler?[orderIndex!] = result;
      notifyListeners();
    } else if (result != null && result is bool) {
      print('back 2');
      fetchListNovelsDashboard();
    }
  }
}
