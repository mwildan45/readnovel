import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class TextStyles {
  static Widget labelBoxText({required String label}) => label.text.bold.lg.make();

  static TextStyle h3TitleTextStyle({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.redHatText(
      fontSize: 18,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle h5TitleTextStyle({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.redHatText(
      fontSize: 14,
      fontWeight: fontWeight,
      color: color,
    );
  }
}

const textSizeNormal = 14;
