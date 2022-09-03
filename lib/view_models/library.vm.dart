import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/requests/library.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class LibraryViewModel extends MyBaseViewModel {
  LibraryViewModel(BuildContext context){
    viewContext = context;
  }

  LibraryRequest libraryRequest = LibraryRequest();
  List<Novel>? bookmarks;
  List<Novel>? histories;

  @override
  void initialise(){
    getHistories();
    getBookmark();
  }

  //
  getHistories() async {

    setBusyForObject(histories, true);

    try {
      histories = await libraryRequest.getHistories(
        {
          'valToken': await AuthServices.getAuthBearerToken()
        }
      );

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    setBusyForObject(histories, false);
  }

  //
  getBookmark() async {

    setBusyForObject(bookmarks, true);

    try {
      bookmarks = await libraryRequest.getBookmark(
        {
          'valToken': await AuthServices.getAuthBearerToken()
        }
      );

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    setBusyForObject(bookmarks, false);
  }

  openNovel(int? id, Novel? novel) async {
    final result = await viewContext?.navigator?.pushNamed(
      AppRoutes.detailNovelRoute,
      arguments: novel,
    ).then((value) {
      initialise();
    });

    // if (result != null && result is Novel) {
    //   print('back 1');
    //   final orderIndex = bookmarks?.indexWhere((e) => e.id == result.id);
    //   bookmarks?[orderIndex!] = result;
    //   notifyListeners();
    // } else if (result != null && result is bool) {
    //   print('back 2');
    //   getBookmark();
    // }
  }


}