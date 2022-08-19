import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class HistoryNovelItem extends StatelessWidget {
  const HistoryNovelItem(
      {Key? key,
      this.widthCover = 80,
      this.heightCover = 105,
      this.image,
      this.index,
      this.author})
      : super(key: key);
  final double widthCover, heightCover;
  final String? image;
  final int? index;
  final String? author;

  @override
  Widget build(BuildContext context) {
    return ZStack(
      [
        HStack(
          [
            Image.network(
                  image ?? '',
                  fit: BoxFit.cover,
                ).w(widthCover).h(heightCover).cornerRadius(5),
            VStack(
              [
                '$author'.text.color(AppColor.redScarlet).sm.make(),
                Flexible(
                  child: 'Novel Placeholder ${index! + 1}'
                      .text
                      .size(13)
                      .ellipsis
                      .maxLines(1)
                      .bold
                      .make(),
                  // .expand(),
                ),
                2.height,
                HStack(
                  [
                    HStack([
                      Icon(
                        FontAwesomeIcons.circleCheck,
                        size: 11,
                        color: Colors.white,
                      ),
                      3.width,
                      'Ongoing'.text.scale(0.8).white.make()
                    ])
                        .p(3)
                        .box
                        .rounded
                        .color(Colors.lightBlueAccent.shade200)
                        .make(),
                    8.width,
                    Icon(
                      FontAwesomeIcons.solidEye,
                      size: 12,
                    ).center(),
                    4.width,
                    '32K'.text.black.scale(0.85).make().pOnly(top: 3)
                  ],
                ),
                4.height,
                'Romance'
                    .text
                    .sm
                    .gray500
                    .make()
                    .px4()
                    .py1()
                    .box
                    .rounded
                    .border(color: AppColor.fadedGrey)
                    .make(),
                2.height,
                UiSpacer.verticalSpace(space: Vx.dp8),
                Flexible(
                  child: 'Lanjut dari Bab 22'
                      .text
                      .ellipsis
                      .size(12)
                      .maxLines(3)
                      .make(),
                ),
              ],
            ).p8().expand()
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).p(6)
            .box
            .white
            .withRounded(value: 8)
            .outerShadowSm
            .shadowOutline(outlineColor: AppColor.fadedGrey)
            .make()
            .pOnly(bottom: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColor.sizzlingRed,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          child: 'Update'
              .text.italic
              .white
              .sm
              .make().p(3),
        ).positioned(top: 0, right: 0)
      ],
    );
  }
}
