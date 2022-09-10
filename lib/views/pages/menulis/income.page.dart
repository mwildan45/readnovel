import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/currency.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/income.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IncomeViewModel>.reactive(
      viewModelBuilder: () => IncomeViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          activeContext: context,
          withAppBar: true,
          customAppBar: true,
          onBackPressed: vm.onBackPressed,
          title: "Pendapatanku",
          body: VStack(
            [
              VStack(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                [
                  (CustomCurrency.currencyIdr().format(
                      double.parse(
                          vm.profile?.income.toString() ??
                              "0")))
                      .text.xl2
                      .bold.black
                      .make().centered(),
                  UiSpacer.verticalSpace(),
                  CustomButton(
                    height: 32,
                    title: "Klaim Pendapatan",
                    isGradientColor: true,
                    shapeRadius: 30,
                    onPressed: () => vm.openClaimIncomeBottomSheet(vm),
                  ).w(178).centered()
                ],
                alignment: MainAxisAlignment.center,
              ).box
                  .rounded
                  .outerShadowMd
                  .shadowOutline(outlineColor: AppColor.grey)
                  .white
                  .p8
                  .make().h20(context)
                  .px16(),
            ],
          )
        );
      },
    );
  }
}
