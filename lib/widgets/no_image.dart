import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_assets.dart';

class NoImagePlaceholder extends StatelessWidget {
  const NoImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(AppImages.imgNoImagePlaceholder, fit: BoxFit.cover, height: 1000, width: 1000.0);
  }
}
