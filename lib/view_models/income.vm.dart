import 'package:flutter/material.dart';
import 'package:read_novel/models/profile.model.dart';
import 'package:read_novel/requests/income.request.dart';
import 'package:read_novel/requests/profile.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/widgets/bottom_sheets/claim_income.bottom_sheet.dart';
import 'package:read_novel/widgets/dialogs/custom_alert.dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class IncomeViewModel extends MyBaseViewModel {
  IncomeViewModel(BuildContext context){
    viewContext = context;
  }

  Profile? profile;
  ProfileRequest profileRequest = ProfileRequest();
  IncomeRequest incomeRequest = IncomeRequest();

  TextEditingController jumlahPenarikan = TextEditingController();

  @override
  void initialise() {
    refreshProfileUser();
  }

  refreshProfileUser() async {
    setBusyForObject(profile, true);
    try {
      final token = await AuthServices.getAuthBearerToken();
      profile = await profileRequest.getProfileUser(token);

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
      // viewContext?.showToast(
      //   msg: "$error",
      //   bgColor: Colors.red,
      // );
    }

    setBusyForObject(profile, false);
  }

  //
  openClaimIncomeBottomSheet(IncomeViewModel vm) {
    claimIncomeBottomSheet(viewContext!, vm);
  }

  //
  claimIncome() async {
    if(formKey.currentState!.validate()){
      setBusy(true);

      try {
        final token = await AuthServices.getAuthBearerToken();
        final apiResp = await incomeRequest.claimIncome(
          token: token,
          amount: jumlahPenarikan.text
        );

        showDialog(
          context: viewContext!,
          barrierDismissible: false,
          builder: (context) {
            return CustomAlertDialog(
              title: apiResp.status,
              contentText: apiResp.message,
            );
          },
        );

        clearErrors();
      } catch (error) {
        print("Error ==> $error");
        setError(error);
        showToast(msg: "failed, please try again later");
        // viewContext?.showToast(
        //   msg: "$error",
        //   bgColor: Colors.red,
        // );
      }

      setBusy(false);
    }
  }

  //
  onBackPressed() {
    //
    print('p');
    viewContext?.navigator?.pop();
  }
}