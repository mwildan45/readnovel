import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class HistoryNovelItem extends StatelessWidget {
  const HistoryNovelItem(
      {Key? key,
      this.widthCover = 75,
      this.heightCover = 100,
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
    return HStack(
      [
        ZStack(
          [
            Image.network(
              image ?? '',
              fit: BoxFit.cover,
            ).w(widthCover).h(heightCover).cornerRadius(5),
            'Update'
                .text
                .size(8)
                .white.italic
                .make()
                .p2()
                .box
                .rightRounded(value: 5)
                .color(AppColor.sizzlingRed)
                .make()
                .positioned(top: 5, left: 0)
          ],
        ),
        VStack(
          [
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
            '$author'.text.sm.make(),
            'Romance'.text.sm.gray500.make(),
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
    ).pOnly(bottom: 8);
  }
}
