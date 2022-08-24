import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget(
      {Key? key,
      required this.labelText,
      this.activeLabelFontSize,
      this.widthIndicator,
      this.isScrollable = true,
      this.height})
      : super(key: key);
  final List<String> labelText;
  final double? activeLabelFontSize;
  final double? widthIndicator;
  final double? height;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: isScrollable,
      indicatorColor: AppColor.royalOrange,
      labelColor: Colors.black,
      unselectedLabelColor: AppColor.romanSilver,
      labelStyle: GoogleFonts.alata(
          fontSize: activeLabelFontSize ?? 13.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5),
      unselectedLabelStyle: GoogleFonts.alata(
          fontSize: 12.5, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      labelPadding: const EdgeInsets.symmetric(horizontal: Vx.dp14),
      // indicatorWeight: 2,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: AppColor.royalOrange),
        insets: isScrollable
            ? EdgeInsets.only(right: widthIndicator ?? 50.0)
            : EdgeInsets.zero,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: List.generate(
          labelText.length,
          (index) => Tab(
                text: labelText[index],
              )),
    ).h(height ?? 30);
  }
}
