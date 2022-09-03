import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomConfirmBuyCoinDialog extends StatelessWidget {
  const CustomConfirmBuyCoinDialog(
      {Key? key,
      this.title,
      this.contentText,
      this.onConfirm,
      this.onLoading = false})
      : super(key: key);
  final String? title;
  final String? contentText;
  final Function()? onConfirm;
  final bool onLoading;

  @override
  Widget build(BuildContext context) {
    print('bool $onLoading');
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: VStack(
        [
          UiSpacer.verticalSpace(),
          Column(
            children: [
              HStack(
                [
                  "Beli Bab".text.bold.lg.make(),
                ],
              ),
              8.height,
              (contentText ?? 'info goes here')
                  .text
                  .medium
                  .color(AppColor.fontColor)
                  .make(),
              12.height,
              onLoading
                  ? const CircularProgressIndicator().w(25).h(25)
                  : UiSpacer.emptySpace(),
            ],
          ).wFull(context),
          UiSpacer.verticalSpace(space: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => context.pop(),
                child: 'Tidak'.text.black.bold.make(),
              ).center(),
              TextButton(
                onPressed: onConfirm ?? () => context.pop(),
                child: HStack(
                  [
                    'Beli'.text.black.bold.make(),
                    8.width,
                    HStack([
                      UiSpacer.buildCoin(size: 12),
                      4.width,
                      '1'.text.lg.black.fontFamily('Calibri').bold.make(),
                    ])
                  ],
                ),
              ).center(),
            ],
          ),
        ],
      ).p8(),
    );
  }
}
