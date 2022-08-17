import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileListItemMenu extends StatelessWidget {
  const ProfileListItemMenu({Key? key, this.icon, this.label, this.onTap}) : super(key: key);
  final IconData? icon;
  final String? label;
  final Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        Icon(icon ?? Icons.currency_bitcoin, size: 16,),
        UiSpacer.horizontalSpace(space: Vx.dp12),
        (label ?? "label").text.bold.letterSpacing(1.1).make().expand(),
        Icon(Icons.arrow_forward_ios, size: 15, color: AppColor.grey,),
      ]
    ).onTap(onTap);
  }
}
