import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/dialogs/custom_alert.dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class MenulisViewModel extends MyBaseViewModel {
  MenulisViewModel(BuildContext context) {
    viewContext = context;
  }

  @override
  void initialise() {
    Future.delayed(const Duration(milliseconds: 500), () {
      openBecomeWriter();
    });
  }

  openBecomeWriter() {
    showDialog(
      context: viewContext!,
      builder: (viewContext) {
        return CustomAlertDialog(
          child: VStack(
            [
              'Sebelum jadi penulis, silahkan melengkapi data diri kamu terlebih dahulu disini'.text.bold.make(),
              CustomButton(
                onPressed: (){
                  viewContext.navigator?.pushNamed(AppRoutes.registerWriterRoute);
                },
                title: 'Lanjut',
              )
            ],
          ),
        );
      },
    );
  }
}
