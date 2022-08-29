import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_sizes.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/widgets/card_image/img_cover.widget.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:velocity_x/velocity_x.dart';

class InfoCoverAuthorGenresWidget extends StatelessWidget {
  const InfoCoverAuthorGenresWidget({
    Key? key,
    required this.detailNovel,
    required this.id,
    this.novel,
  }) : super(key: key);
  final DetailNovel? detailNovel;
  final Novel? novel;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ZStack(
      [
        Image.network(
          novel?.cover ?? imgList[0],
          height: 250,
          width: double.maxFinite,
          fit: BoxFit.cover,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Image.asset(AppIcons.noImage).wFull(context).h(250);
          },
        ),
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: 250.height.w(double.maxFinite).box.white.make(),
        ),
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstOut,
          child: 251.height.w(double.maxFinite).box.white.make(),
        ),
        VStack(
          [
            UiSpacer.verticalSpace(space: Vx.dp24),
            Hero(
              tag: id,
              child: ImgCoverWidget(
                image: novel?.cover ?? imgList[0],
                widthCover: AppSizes.appCoverWidthMedium,
                heightCover: AppSizes.appCoverHeightMedium,
              ),
            ),
            UiSpacer.verticalSpace(space: Vx.dp12),
            'Author: ${novel?.author}'.text.color(AppColor.black).sm.make(),
            8.height,
            detailNovel?.genre == null
                ? UiSpacer.emptySpace()
                : Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 6,
                    spacing: 6,
                    children: [
                      ...buildGenresBox(detailNovel),
                    ],
                  ).px24(),
            UiSpacer.verticalSpace(space: Vx.dp16),
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).center(),
      ],
    );
  }

  buildGenresBox(DetailNovel? model) {
    return model?.genre?.map((e) {
      return e.text.white
          .size(11)
          .make()
          .px8()
          .py4()
          .box
          .withRounded(value: 8)
          .color(AppColor.royalOrange)
          .make();
    }).toList();
  }
}
