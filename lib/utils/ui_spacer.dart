import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UiSpacer {
  //space between widgets vertically
  static Widget verticalSpace({double space = 20}) => SizedBox(height: space);

  //space between widgets horizontally
  static Widget horizontalSpace({double space = 20}) => SizedBox(width: space);

  static Widget formVerticalSpace({double space = 15}) =>
      SizedBox(height: space);

  static Widget emptySpace() => SizedBox.shrink();
  static Widget expandedSpace() => const Expanded(
    child: SizedBox.shrink(),
  );

  static Widget verticalDivider({Color? color}) => VxBox().color(color ?? Colors.cyan).width(2).height(Vx.dp12).make().pOnly(right: Vx.dp8);
  static Widget divider({double width = 20, Color? color, double? thickness}) => VxBox().color(color ?? AppColor.fadedGrey.withOpacity(0.5)).width(width).height(thickness ?? 1.2).rounded.make().pOnly(top: Vx.dp3);

  static Widget greyedVerticalDivider() => VxBox().color(AppColor.grey).width(1).height(Vx.dp12).make().px4();

  static Widget buildCoin({double? size}) {
    return Icon(
      FontAwesomeIcons.c,
      size: size ?? 12,
      color: AppColor.fontColor,
    )
        .box
        .p3
        .color(Colors.yellow)
        .roundedFull
        .make()
        .box
        .color(Colors.orange)
        .p3
        .roundedFull
        .make();
  }
}
