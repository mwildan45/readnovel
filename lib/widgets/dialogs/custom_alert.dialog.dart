import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key, this.title, this.contentText}) : super(key: key);
  final String? title;
  final String? contentText;

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
          Image.asset(AppGifs.success, fit: BoxFit.cover,).wFull(context).h16(context),
          UiSpacer.verticalSpace(),
          Column(
            children: [
              (title ?? 'Yeay!').text.bold.lg.make(),
              8.height,
              (contentText ?? 'info goes here').text.color(AppColor.romanSilver).make(),
            ],
          ).wFull(context),
          UiSpacer.verticalSpace(),
          TextButton(onPressed: () => context.pop(), child: 'Selesai'.text.sm.black.bold.make()).center(),
        ],
      ).p8(),
    );
  }
}
