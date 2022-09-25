import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:read_novel/models/coins_topup.model.dart';
import 'package:read_novel/models/ipaymu.model.dart';
import 'package:read_novel/models/profile.model.dart';
import 'package:read_novel/requests/coin.request.dart';
import 'package:read_novel/requests/profile.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class CoinViewModel extends MyBaseViewModel {
  CoinViewModel(BuildContext context) {
    viewContext = context;
  }

  CoinRequest coinRequest = CoinRequest();
  List<CoinsTopUp>? coinsTopUp;
  iPaymuResponse? iPaymu;
  String? urlPayment;
  String? coinUser;
  Profile? profile;
  ProfileRequest profileRequest = ProfileRequest();

  @override
  void initialise() {
    coinUser = getStringAsync(AppStrings.coinUser);
    notifyListeners();
    getCoinsTopUp();
  }

  getCoinsTopUp() async {
    setBusyForObject(coinsTopUp, true);

    try {
      coinsTopUp = await coinRequest.getListAvailableCoinsTopUp();

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    setBusyForObject(coinsTopUp, false);
  }

  buyCoin(coinId) async {
    viewContext?.loaderOverlay.show();

    try {
      final token = await AuthServices.getAuthBearerToken();
      iPaymu = await coinRequest.buyCoin(coinId: coinId, token: token);
      openInAppWebViewPayment(iPaymu?.data?.url);
      notifyListeners();

      clearErrors();
    } catch (error) {
      showToast(msg: AppStrings.errorApiMsg);
      print("Error ==> $error");
      setError(error);
    }

    viewContext?.loaderOverlay.hide();
  }

  openInAppWebViewPayment(url) async {
    viewContext?.navigator
        ?.pushNamed(AppRoutes.paymentWebView, arguments: url)
        .then((value) => refreshProfileUser());
  }

  refreshProfileUser() async {
    setBusy(true);
    try {
      final token = await AuthServices.getAuthBearerToken();
      profile = await profileRequest.getProfileUser(token);

      setValue(AppStrings.coinUser, profile?.coin.toString());
      coinUser = getStringAsync(AppStrings.coinUser);

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
}
