import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_sizes.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/widgets/img_cover.widget.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:velocity_x/velocity_x.dart';

class InfoCoverAuthorGenresWidget extends StatelessWidget {
  const InfoCoverAuthorGenresWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZStack(
      [
        Image.network(
          imgList[2],
          height: 250,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect
                .height));
          },
          blendMode: BlendMode.dstIn,
          child: 250.height
              .w(double.maxFinite)
              .box
              .white
              .make(),
        ),
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect
                .height));
          },
          blendMode: BlendMode.dstOut,
          child: 250.height
              .w(double.maxFinite)
              .box
              .white
              .make(),
        ),
        VStack(
          [
            UiSpacer.verticalSpace(space: Vx.dp24),
            ImgCoverWidget(
              image: imgList[2],
              widthCover: AppSizes.appCoverWidthMedium,
              heightCover: AppSizes.appCoverHeightMedium,
            ),
            UiSpacer.verticalSpace(space: Vx.dp12),
            'Author: Shienny M.S.'.text
                .color(AppColor.fontColor)
                .sm
                .make(),
            8.height,
            'Romance'.text.white
                .size(11)
                .make()
                .px8()
                .py4()
                .box
                .withRounded(value: 8)
                .color(AppColor.royalOrange)
                .make(),
            UiSpacer.verticalSpace(space: Vx.dp16),
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).center(),
      ],
    );
  }
}
