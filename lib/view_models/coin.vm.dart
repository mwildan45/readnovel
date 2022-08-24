import 'package:flutter/material.dart';
import 'package:read_novel/models/coins_topup.model.dart';
import 'package:read_novel/requests/coin.request.dart';
import 'package:read_novel/view_models/base.view_model.dart';

class CoinViewModel extends MyBaseViewModel {
  CoinViewModel(BuildContext context){
    viewContext = context;
  }

  CoinRequest coinRequest = CoinRequest();
  List<CoinsTopUp>? coinsTopUp;

  getCoinsTopUp() async {
    setBusyForObject(coinsTopUp, true);

    try {
      coinsTopUp = await coinRequest.getCoinTopUp();

      clearErrors();
    } catch (error) {
      setError(error);
    }

    setBusyForObject(coinsTopUp, false);
  }
}