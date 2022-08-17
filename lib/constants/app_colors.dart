
import 'package:flutter/material.dart';

class AppColor {
  static Color get accentColor => const Color(0xFFFFFFFF);
  static Color get primaryColor => const Color(0xFFF0F4FF);
  static Color get primaryColorDark => const Color(0xFFD5E0FF);
  static Color get cursorColor => accentColor;

  //Shimmer Colors
  static Color shimmerBaseColor = Colors.grey[300] ?? Colors.white;
  static Color shimmerHighlightColor = Colors.grey[200] ?? Colors.grey;

  //texts
  static Color lightMalachiteGreen = const Color(0xFF42F38C);
  static Color sizzlingRed = const Color(0xFFF93154);
  static Color aliceBlue = const Color(0xFFF0FFFD);
  static Color cyan = Colors.cyan;

  static Color fadedGrey = Colors.grey.shade300;
  static Color grey = Colors.grey.shade400;

  // static Color get openColor => Vx.hexToColor(colorEnv('openColor'));

}
