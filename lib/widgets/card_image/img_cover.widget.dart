import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:velocity_x/velocity_x.dart';

class ImgCoverWidget extends StatelessWidget {
  const ImgCoverWidget(
      {Key? key,
      required this.image,
      required this.widthCover,
      required this.heightCover,
      this.shapeRadius = 8})
      : super(key: key);
  final String? image;
  final double widthCover, heightCover;
  final double? shapeRadius;

  @override
  Widget build(BuildContext context) {
    try {
      return Image.network(
        image ?? 'http://',
        fit: BoxFit.cover,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset(AppIcons.noImage).w(widthCover).h(heightCover);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Container(
              color: AppColor.ghostWhite,
              child: Image.asset(AppImages.appLogoOnly, width: 38,))
              .w(widthCover)
              .h(heightCover)
              .cornerRadius(shapeRadius!);
        },
      ).w(widthCover).h(heightCover).cornerRadius(shapeRadius!);
    } catch (e) {
      return Image.asset(AppIcons.noImage).w(widthCover).h(heightCover);
    }
  }
}
