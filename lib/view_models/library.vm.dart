import 'package:flutter/material.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/requests/library.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';

class LibraryViewModel extends MyBaseViewModel {
  LibraryViewModel(BuildContext context){
    viewContext = context;
  }

  LibraryRequest libraryRequest = LibraryRequest();
  List<Novel>? bookmark;

  @override
  void initialise(){
    getBookmark();
  }

  //
  getBookmark() async {

    setBusyForObject(bookmark, true);

    try {
      bookmark = await libraryRequest.getBookmark(
        {
          'valToken': await AuthServices.getAuthBearerToken()
        }
      );

      clearErrors();
    } catch (error) {
      setError(error);
    }

    setBusyForObject(bookmark, false);
  }

}