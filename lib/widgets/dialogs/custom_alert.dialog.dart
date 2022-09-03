import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key, this.title, this.contentText, this.failedResult = false}) : super(key: key);
  final String? title;
  final String? contentText;
  final bool failedResult;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: VStack(
        [
          failedResult ? UiSpacer.emptySpace() : Image.asset(AppGifs.success, fit: BoxFit.cover,).wFull(context).h16(context),
          UiSpacer.verticalSpace(),
          Column(
            children: [
              (title ?? 'Yeay!').text.color(failedResult ? AppColor.redScarlet : Colors.black).bold.lg.make(),
              8.height,
              (contentText ?? 'info goes here').text.center.color(AppColor.romanSilver).make().px12(),
            ],
          ).wFull(context),
          UiSpacer.verticalSpace(),
          TextButton(onPressed: () => context.pop(), child: 'Selesai'.text.sm.black.bold.make()).center(),
        ],
      ).p8(),
    );
  }
}
