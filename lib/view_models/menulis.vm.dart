import 'dart:async';

import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/services/app.services.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/dialogs/custom_alert.dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class MenulisViewModel extends MyBaseViewModel {
  MenulisViewModel(BuildContext context) {
    viewContext = context;
  }

  int currentIndex = 0;
  PageController pageViewController = PageController(initialPage: 0);
  StreamSubscription? registerPenulisPageChangeStream;

  @override
  void initialise() {
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   openBecomeWriter();
    // });

    registerPenulisPageChangeStream = AppService.instance?.homePageIndex.stream.listen(
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
    registerPenulisPageChangeStream?.cancel();
  }

  //
  onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  //
  onTabChange(int index) {
    print("index $index");
    if(index >= 0) {
      currentIndex = index;
      pageViewController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
      notifyListeners();
    }else{
      viewContext?.navigator?.pop();
    }
  }

  openBecomeWriter() {
    viewContext?.navigator?.pushNamed(AppRoutes.registerWriterRoute);
    // showDialog(
    //   context: viewContext!,
    //   builder: (viewContext) {
    //     return CustomAlertDialog(
    //       child: VStack(
    //         [
    //           'Sebelum jadi penulis, silahkan melengkapi data diri kamu terlebih dahulu disini'.text.bold.make(),
    //           CustomButton(
    //             onPressed: (){
    //               viewContext.navigator?.pushNamed(AppRoutes.registerWriterRoute);
    //             },
    //             title: 'Lanjut',
    //           )
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
