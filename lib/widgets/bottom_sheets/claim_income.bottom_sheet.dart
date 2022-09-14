import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/services/validator.service.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/income.vm.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/form_field/general.form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

Future<dynamic> claimIncomeBottomSheet(
    BuildContext context, IncomeViewModel viewModel) {
  return showModalBottomSheet(
    // expand: true,
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    barrierColor: Colors.black38,
    backgroundColor: Colors.white,
    builder: (context) {
      return AnimatedPadding(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ViewModelBuilder<IncomeViewModel>.reactive(
            viewModelBuilder: () => IncomeViewModel(context),
            onModelReady: (model) {},
            builder: (context, vm, child) {
              return VStack(
                [
                  8.height,
                  'Klaim pendapatanmu'.text.bold.make().centered(),
                  4.height,
                  // UiSpacer.divider(width: double.maxFinite),
                  UiSpacer.verticalSpace(),
                  Form(
                    key: vm.formKey,
                    child: VStack([
                      CustomTextFormField(
                        textEditingController: vm.jumlahPenarikan,
                        height: 48,
                        labelText: '* Jumlah Penarikan',
                        hintText: 'Tulis jumlah penarikan',
                        maxLines: 1,
                        radius: 10,
                        validator: (val) => FormValidator.validateEmpty(val,
                            errorTitle: 'Jumlah Penarikan'),
                        keyboardType: TextInputType.number,
                      ),
                      12.height,
                      CustomButton(
                        isGradientColor: true,
                        loading: vm.isBusy,
                        shapeRadius: 10,
                        title: 'Proses',
                        titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        onPressed: vm.claimIncome,
                      ).centered()
                    ]),
                  ),
                  UiSpacer.verticalSpace(),
                ],
                crossAlignment: CrossAxisAlignment.stretch,
              ).p12();
            }),
      );
    },
  );
}
