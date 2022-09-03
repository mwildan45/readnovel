
import 'package:flutter/material.dart';

class AppColor {
  static Color get accentColor => const Color(0xFFFFFFFF);
  static Color get primaryColor => const Color(0xffffffff);
  static Color get primaryColorDark => grey;
  static Color get cursorColor => royalOrange;
  static Color fontColor = const Color(0xFF727272);
  static Color black = const Color(0xFF0E0E0E);

  //Shimmer Colors
  static Color shimmerBaseColor = Colors.grey[300] ?? Colors.white;
  static Color shimmerHighlightColor = Colors.grey[200] ?? Colors.grey;

  //texts
  static Color lightMalachiteGreen = const Color(0xFF42F38C);
  static Color guppieGreen = const Color(0xff26d968);
  static Color sizzlingRed = const Color(0xFFF93154);
  static Color aliceBlue = const Color(0xFFF0FFFD);
  static Color redScarlet = const Color(0xFFFE4C81);
  static Color royalOrange = const Color(0xFFfd9345);
  static Color cerisePink = const Color(0xFFeb3389);
  static Color azureishWhite = const Color(0xFFEFEBE1);
  static Color ghostWhite = const Color(0xFFF7F9FD);
  static Color ghostWhite2 = const Color(0xFFF3F6FF);
  static Color romanSilver = const Color(0xFF8C8E99);
  static Color lotion = const Color(0xFFFAFAFA);
  static Color yellowPastel = const Color(0xFFFDFD96);
  static Color unitedNationsBlue = const Color(0xFF4A9BF0);
  static Color burlywood = const Color(0xFFDBBB8A);
  static Color cyan = Colors.cyan;

  static Color fadedGrey = Colors.grey.shade300;
  static Color grey = Colors.grey.shade400;


  static List<Color> listChooseBgReadColor = [primaryColor, black, yellowPastel];


  // static Color get openColor => Vx.hexToColor(colorEnv('openColor'));

}
