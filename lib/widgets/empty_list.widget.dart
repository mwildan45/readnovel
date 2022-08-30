import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({Key? key, this.textEmpty}) : super(key: key);
  final String? textEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppImages.appLogoOnly, color: AppColor.grey, width: Vx.dp40, height: Vx.dp40,),
        8.height,
        (textEmpty ?? ' daftar kosong').text.color(AppColor.grey).bold.sm.make()
      ],
    ).centered();
  }
}
