import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/widgets/card_image/img_cover.widget.dart';
import 'package:velocity_x/velocity_x.dart';

class HistoryNovelItem extends StatelessWidget {
  const HistoryNovelItem(
      {Key? key,
      this.widthCover = 90,
      this.heightCover = 125,
      this.image,
      this.index,
      this.author,
      this.novel,
      this.onItemTap})
      : super(key: key);
  final double widthCover, heightCover;
  final String? image;
  final int? index;
  final String? author;
  final Novel? novel;
  final Function()? onItemTap;

  @override
  Widget build(BuildContext context) {
    return ZStack(
      [
        HStack(
          [
            novel == null
                ? const SizedBox.shrink()
                : Hero(
                    tag: novel?.sectionId ?? "0",
                    child: ImgCoverWidget(
                      image: novel?.cover,
                      widthCover: widthCover,
                      heightCover: heightCover,
                    ),
                  ),
            VStack([
              (author ?? novel?.author ?? "author")
                  .text
                  .color(AppColor.redScarlet)
                  .sm
                  .ellipsis
                  .make()
                  .flexible(),
              Flexible(
                child: (novel?.title ?? "Novel Placeholder")
                    .text
                    .size(13)
                    .ellipsis
                    .maxLines(1)
                    .bold
                    .make(),
                // .expand(),
              ),
              2.height,
              Flexible(
                child: (novel?.sinopsis ?? 'no synopsis')
                    .text
                    .ellipsis
                    .size(12)
                    .maxLines(3)
                    .make(),
              ),
            ]).px8().py4().expand()
          ],
          crossAlignment: CrossAxisAlignment.center,
        )
            .p(6)
            .box
            .white
            .withRounded(value: 8)
            .outerShadow
            .shadowOutline(outlineColor: AppColor.grey)
            .make(),
        Container(
          decoration: BoxDecoration(
            color: AppColor.redScarlet,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          child: "Lanjutkan: ${novel?.chapterTitle ?? '20 Chapter'}"
              .text
              .white
              .scale(0.82)
              .make()
              .pOnly(bottom: 1)
              .px(6)
              .py4(),
        ).positioned(top: 0, right: 0),
      ],
    ).onTap(onItemTap);
  }
}
