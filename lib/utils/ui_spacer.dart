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

  static Widget verticalDivider() => VxBox().color(Colors.cyan).width(2).height(Vx.dp12).make().pOnly(right: Vx.dp8);
  static Widget divider({double width = 20}) => VxBox().color(Colors.cyan).width(width).height(2).make().pOnly(top: Vx.dp3);

}
