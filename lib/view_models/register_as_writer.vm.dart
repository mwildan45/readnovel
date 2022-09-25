import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path/path.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/profile.model.dart';
import 'package:read_novel/requests/register_as_writer.request.dart';
import 'package:read_novel/services/app.services.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/widgets/dialogs/custom_alert.dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterAsWriterViewModel extends MyBaseViewModel {
  RegisterAsWriterViewModel(BuildContext context) {
    viewContext = context;
  }

  int currentIndex = 0;
  PageController pageViewController = PageController(initialPage: 0);
  StreamSubscription? registerPenulisPageChangeStream;

  RegisterAsWriterRequest registerAsWriterRequest = RegisterAsWriterRequest();

  TextEditingController realNameCon = TextEditingController();
  TextEditingController namaPenaCon = TextEditingController();
  TextEditingController noIdCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController bankNameCon = TextEditingController();
  TextEditingController bankOwnerAccountCon = TextEditingController();
  TextEditingController bankAccountCon = TextEditingController();

  XFile? selectedPhotoKTP;
  DateTime? selectedTglLahir;
  String? formatedTglLahir;
  DateFormat format = DateFormat("dd MMMM yyyy", "id_ID");

  Profile? profile;

  @override
  void initialise() {
    registerPenulisPageChangeStream =
        AppService.instance?.homePageIndex.stream.listen(
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
  onImageSelected(XFile file) {
    selectedPhotoKTP = file;
    notifyListeners();
  }

  //
  onTglLahirSelected(DateTime date) {
    print('confirm $date');
    selectedTglLahir = date;
    formatedTglLahir = format.format(selectedTglLahir!);
    notifyListeners();
  }

  //
  onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  //
  onTabChange(int index, {RegisterAsWriterViewModel? vm}) {
    if (index >= 0) {
      if (selectedPhotoKTP == null) {
        showToast(msg: 'Upload foto identitas kamu terlebih dahulu');
      } else if (index > 1) {
        if (formKey.currentState!.validate()) {
          if (selectedTglLahir == null) {
            showToast(msg: 'tgl lahir masih kosong');
          } else {
            viewContext?.navigator?.pushNamed(
                AppRoutes.confirmRegisterWriterRoute,
                arguments: vm);
          }
        }
      } else {
        currentIndex = index;
        pageViewController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
        );
        notifyListeners();
      }
    } else {
      viewContext?.navigator?.pop();
    }
  }


  //handle become writer
  Future handleBecomeWriter() async {
    setBusy(true);

    try {
      final apiResponse = await registerAsWriterRequest.handleBecomeWriter(
          nama_asli: realNameCon.text,
          nama_pena: namaPenaCon.text,
          tanggal_lahir: ("${selectedTglLahir!.year}-${selectedTglLahir!.month}-${selectedTglLahir!.day}"),
          nomor_id: noIdCon.text,
          image_id: File(selectedPhotoKTP!.path),
          alamat: addressCon.text,
          telepon: phoneCon.text,
          nama_bank: bankNameCon.text,
          atas_nama: bankOwnerAccountCon.text,
          rekening: bankAccountCon.text);

      print('${apiResponse.data}');
      profile = Profile.fromJson(apiResponse.data);

      await AuthServices.setProfileValue(profile);

      showDialog(
        context: viewContext!,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: CustomAlertDialog(
              contentText: apiResponse.message.toString(),
            ),
          );
        },
      ).then((value) {
        viewContext?.navigator?.pop();
        viewContext?.navigator?.pop();
      });

      clearErrors();
    } catch (error) {
      print("Register Writer Error ==> $error");
      setError(error);
    }

    setBusy(false);
  }
}
