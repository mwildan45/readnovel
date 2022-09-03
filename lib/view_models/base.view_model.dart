import 'package:fluttertoast/fluttertoast.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MyBaseViewModel extends BaseViewModel {
  //
  BuildContext? viewContext;
  final currencySymbol = AppStrings.appCurrency;
  GlobalKey pageKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final widgetKey = GlobalKey();

  void initialise() {

  }

  newPageKey() {
    pageKey = GlobalKey<FormState>();
    notifyListeners();
  }

  showToast({required String msg, Color? color}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color ?? AppColor.cerisePink,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
