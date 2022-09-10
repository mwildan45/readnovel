import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:read_novel/models/banner.model.dart';
import 'package:read_novel/models/genres.model.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/models/novels_dashboard.model.dart';
import 'package:read_novel/requests/dashboard.request.dart';
import 'package:read_novel/requests/genres.request.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class DashboardViewModel extends MyBaseViewModel {
  DashboardViewModel(BuildContext context) {
    viewContext = context;
  }

  int currentSliderIndex = 0;
  final CarouselController carouselController = CarouselController();
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  DashboardRequest dashboardRequest = DashboardRequest();
  GenresRequest genresRequest = GenresRequest();
  BannerHeader? bannerData;
  ListNovelsDashboard? data;
  List<Genres>? genres;
  List<Novel>? novelsPerGenre;
  String? selectedGenre;
  String? coinUser;

  @override
  void initialise() {
    coinUser = getStringAsync(AppStrings.coinUser);
    fetchBanner();
    fetchListNovelsDashboard();
    fetchGenres();
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
  fetchGenres() async {
    setBusyForObject(genres, true);
    try {

      genres = await genresRequest.getGenres();

      fetchNovelsPerGenre(genres?.first.id, genres?.first.name);

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    setBusyForObject(genres, false);
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

  //
  fetchNovelsPerGenre(idGenre, nameGenre) async {
    setBusyForObject(novelsPerGenre, true);
    novelsPerGenre = null;
    selectedGenre = nameGenre;

    try {

      novelsPerGenre = await dashboardRequest.getNovelsPerGenres(idGenre);

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
      // viewContext?.showToast(
      //   msg: "$error",
      //   bgColor: Colors.red,
      // );
    }

    setBusyForObject(novelsPerGenre, false);
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

  openSeeAllNovels(String sectionName) async {
    print('section $sectionName');
    await viewContext?.navigator?.pushNamed(
      AppRoutes.seeAllRoute,
      arguments: {
        'sectionName': sectionName
      },
    );
  }

  navToResultSearch(String keyword) async {
    print('section $keyword');
    await viewContext?.navigator?.pushNamed(
      AppRoutes.seeAllRoute,
      arguments: {
        'sectionName': 'Hasil',
        'keyword': keyword
      },
    );
  }

  navKoinkuPage(){
    viewContext?.navigator?.pushNamed(AppRoutes.koinkuRoute);
  }
}
