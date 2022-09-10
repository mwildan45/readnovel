import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/models/profile.model.dart';
import 'package:read_novel/requests/profile.request.dart';
import 'package:read_novel/requests/write.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class MenuMenulisViewModel extends MyBaseViewModel {
  MenuMenulisViewModel(BuildContext context) {
    viewContext = context;
  }

  Profile? profile;
  List<Novel>? novel;
  ProfileRequest profileRequest = ProfileRequest();
  WriteRequest writeRequest = WriteRequest();
  int? levelUser;

  @override
  void initialise() {
    refreshProfileUser();
  }

  refreshProfileUser() async {
    setBusy(true);
    try {
      final token = await AuthServices.getAuthBearerToken();
      profile = await profileRequest.getProfileUser(token);

      setValue(AppStrings.levelUser, profile?.level);
      levelUser = profile?.level;
      notifyListeners();
      if (profile?.level != 0) {
        fetchMyOwnNovels();
      }

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
  fetchMyOwnNovels() async {
    setBusyForObject(novel, true);

    try {
      novel = await writeRequest.getMyNovels();

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
      showToast(msg: 'error showing own novels: $error');
      // viewContext?.showToast(
      //   msg: "$error",
      //   bgColor: Colors.red,
      // );
    }

    setBusyForObject(novel, false);
  }

  //nav function section
  navBecomeWriter() {
    viewContext?.navigator?.pushNamed(AppRoutes.registerWriterRoute).then(
      (value) {
        refreshProfileUser();
      },
    );
  }

  navPusatBantuanPage() {
    viewContext?.navigator?.pushNamed(AppRoutes.faqRoute);
  }

  navCreateNovel() {
    final result =
        viewContext?.navigator?.pushNamed(AppRoutes.createNovelRoute).then(
      (value) {
        fetchMyOwnNovels();
      },
    );

    if (result != null && result is bool) {
      fetchMyOwnNovels();
    }
  }

  navUpdateNovel(idNovel) {
    final result = viewContext?.navigator
        ?.pushNamed(AppRoutes.updateNovelRoute, arguments: idNovel)
        .then(
      (value) {
        fetchMyOwnNovels();
      },
    );

    if (result != null && result is bool) {
      fetchMyOwnNovels();
    }
  }

  navOpenIncome() async {
    viewContext?.navigator?.pushNamed(AppRoutes.incomeAuthor);
  }
}
