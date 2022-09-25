import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/read_chapter.vm.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customConfirmDialog({
  required BuildContext context,
  String? title,
  String? contentText,
  Function()? onConfirm,
  Function()? onCancel,
}) {
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
                (title ?? "title").text.bold.lg.make(),
              ],
            ),
            8.height,
            (contentText ?? 'info goes here')
                .text
                .medium.center
                .color(AppColor.fontColor)
                .make(),
          ],
        ).wFull(context),
        UiSpacer.verticalSpace(space: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: onCancel ?? () => context.pop(),
              child: 'Tidak'.text.black.bold.make(),
            ).center(),
            TextButton(
              onPressed: onConfirm ?? () => context.pop(),
              child: 'Ya'.text.black.bold.make(),
            ).center(),
          ],
        ),
      ],
    ).p8(),
  );
}
