import 'dart:async';

import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:read_novel/models/ages.model.dart';
import 'package:read_novel/models/genres.model.dart';
import 'package:read_novel/requests/ages.request.dart';
import 'package:read_novel/requests/genres.request.dart';
import 'package:read_novel/services/app.services.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class MenulisViewModel extends MyBaseViewModel {
  MenulisViewModel(BuildContext context) {
    viewContext = context;
  }

  int currentIndex = 0;
  PageController pageViewController = PageController(initialPage: 0);
  StreamSubscription? menulisPageChangeStream;

  GenresRequest genresRequest = GenresRequest();
  AgesRequest agesRequest = AgesRequest();
  List<Genres>? genres;
  List<Ages>? ages;
  var agesMap = <int, bool>{};
  var genresMap = <int, bool>{};

  TextEditingController novelName = TextEditingController();
  TextEditingController chapterName = TextEditingController();
  HtmlEditorController chapterContent = HtmlEditorController();


  @override
  void initialise() {
    menulisPageChangeStream = AppService.instance?.homePageIndex.stream.listen(
      (index) {
        onTabChange(index);
      },
    );

    fetchAges();
    fetchGenres();
  }

  //
  @override
  dispose() {
    super.dispose();
    menulisPageChangeStream?.cancel();
  }

  //
  onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  //
  onTabChange(int index) {
    print("index $index");
    if (index >= 0) {
      currentIndex = index;
      pageViewController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
      notifyListeners();
    } else {
      viewContext?.navigator?.pop();
    }
  }

  //
  fetchGenres() async {
    setBusyForObject(genres, true);
    try {

      genres = await genresRequest.getGenres();

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    setBusyForObject(genres, false);
  }

  //
  fetchAges() async {
    setBusyForObject(ages, true);
    try {

      ages = await agesRequest.getAges();

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    setBusyForObject(ages, false);
  }

  void handleSelectGenre(id, action) {
    genresMap.putIfAbsent(id, () => action);
    genresMap.update(id, (value) => action);
    notifyListeners();
  }


  void handleSelectAge(id, action) {
    agesMap.putIfAbsent(id, () => action);
    agesMap.update(id, (value) => action);
    notifyListeners();
  }

}
