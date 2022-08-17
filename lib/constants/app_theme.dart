import 'package:read_novel/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //
  ThemeData lightTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.redHatDisplay().fontFamily,
      primaryColor: AppColor.primaryColor,
      primaryColorDark: AppColor.primaryColorDark,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.grey,
        cursorColor: AppColor.cursorColor,
      ),
      backgroundColor: Colors.white,
      cardColor: Colors.grey[50],
      textTheme: const TextTheme(
        headline3: TextStyle(
          color: Colors.black,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      // brightness: Brightness.light,
      // CUSTOMIZE showDatePicker Colors
      dialogBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: AppColor.primaryColorDark,
        secondary: AppColor.accentColor,
        brightness: Brightness.light,
      ),
      buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      highlightColor: Colors.grey[400],
    );
  }
}
