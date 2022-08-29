import 'package:read_novel/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class InputStyles {
  //get the border for the textform field
  static InputBorder inputEnabledBorder({double? radius}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.grey,
      ),
      borderRadius: BorderRadius.circular(radius ?? 1000),
    );
  }

  //get the border for the textform field
  static InputBorder inputFocusBorder({double? radius}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.grey,
      ),
      borderRadius: BorderRadius.circular(radius ?? 1000),
    );
  }


  //
  //get the border for the textform field
  static InputBorder inputUnderlineEnabledBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.primaryColor,
      ),
      borderRadius: BorderRadius.circular(Vx.dp4),
    );
  }

  //get the border for the textform field
  static InputBorder inputUnderlineFocusBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.primaryColorDark,
      ),
      borderRadius: BorderRadius.circular(Vx.dp4),
    );
  }
}
