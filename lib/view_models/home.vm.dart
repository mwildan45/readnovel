
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:read_novel/services/app.services.dart';
import 'package:read_novel/view_models/base.view_model.dart';

class HomeViewModel extends MyBaseViewModel {
  HomeViewModel(BuildContext context){
    viewContext = context;
  }

  //
  int currentIndex = 0;
  PageController pageViewController = PageController(initialPage: 0);
  StreamSubscription? homePageChangeStream;
  List<String> listMenu = ['Home', 'Library', 'Menulis', 'Saya'];
  List<IconData> listIconMenu = [FontAwesomeIcons.house, FontAwesomeIcons.bookOpen, FontAwesomeIcons.pencil, FontAwesomeIcons.solidUser];


  @override
  void initialise() async {
    //
    // handleAppUpdate(viewContext);
    // //
    // currentVendor = await AuthServices.getCurrentVendor(force: true);
    notifyListeners();
    //

    //
    homePageChangeStream = AppService.instance?.homePageIndex.stream.listen(
          (index) {
        //
        onTabChange(index);
      },
    );
  }

  //
  @override
  dispose() {
    super.dispose();
    homePageChangeStream?.cancel();
  }

  //
  onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  //
  onTabChange(int index) {
    currentIndex = index;
    pageViewController.animateToPage(
      currentIndex,
      duration: const Duration(microseconds: 5),
      curve: Curves.bounceInOut,
    );
    notifyListeners();
  }
}