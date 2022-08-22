import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:velocity_x/velocity_x.dart';

class ImgCoverWidget extends StatelessWidget {
  const ImgCoverWidget(
      {Key? key,
      required this.image,
      required this.widthCover,
      required this.heightCover, this.shapeRadius = 8})
      : super(key: key);
  final String? image;
  final double widthCover, heightCover;
  final double? shapeRadius;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image ?? '',
      fit: BoxFit.cover,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset(AppIcons.noImage).w(widthCover).h(heightCover);
      },
    ).w(widthCover).h(heightCover).cornerRadius(shapeRadius!);
  }
}
