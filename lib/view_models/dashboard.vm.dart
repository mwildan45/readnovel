import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/models/banner.model.dart';
import 'package:read_novel/requests/dashboard.request.dart';
import 'package:read_novel/view_models/base.view_model.dart';

class DashboardViewModel extends MyBaseViewModel {
  DashboardViewModel(BuildContext context) {
    viewContext = context;
  }

  DashboardRequest dashboardRequest = DashboardRequest();
  int currentSliderIndex = 0;
  final CarouselController carouselController = CarouselController();
  BannerHeader? bannerData;

  @override
  void initialise() {
    getBanner();
  }

  onSliderChanged(index, reason) {
    currentSliderIndex = index;
    notifyListeners();
  }

  getBanner() async {
    setBusy(true);
    try {

      bannerData = await dashboardRequest.getBanners();

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
}
