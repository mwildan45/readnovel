import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/widgets/card_image/img_cover.widget.dart';
import 'package:velocity_x/velocity_x.dart';

class NovelItem extends StatelessWidget {
  const NovelItem({
    Key? key,
    this.index,
    this.height = 170,
    this.width = 100,
    this.widthCover = 90,
    this.heightCover = 125,
    this.isInfoOnRightPosition = false,
    this.smallNovelItem = false,
    this.onItemTap,
    this.novel,
    this.image,
    this.idNovel,
    this.author,
    this.genres,
    this.novelName,
  }) : super(key: key);

  final String? image;
  final int? index;

  final int? idNovel;
  final double width, height, widthCover, heightCover;

  final String? author;
  final String? genres;
  final String? novelName;
  final bool isInfoOnRightPosition;
  final bool smallNovelItem;
  final Function()? onItemTap;
  final Novel? novel;

  @override
  Widget build(BuildContext context) {
    if (!isInfoOnRightPosition) {
      if (smallNovelItem) {
        //SMALL ITEM CONTENT

        return InkWell(
          onTap: onItemTap,
          child: HStack(
            [
              ZStack(
                [
                  buildCoverHero(
                    width: 68,
                    height: 78,
                  ),
                  // chapterBox(null).positioned(bottom: 0, left: 0)
                ],
              ),
              5.width,
              VStack(
                [
                  buildNovelTitle(maxLines: 2),
                  3.height,
                  (novel?.author ?? "author")
                      .text
                      .sm
                      .medium
                      .ellipsis
                      .color(AppColor.redScarlet)
                      .make()
                      .flexible(),
                  // genres == null
                  //     ? const SizedBox.shrink()
                  //     : 'Romance'.text.sm.gray500.make(),
                ],
                crossAlignment: CrossAxisAlignment.start,
              ).expand()
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).w(width),
        );
      } else {
        //CONTENT BOTTOM POSITION

        return GestureDetector(
          onTap: onItemTap,
          child: VStack(
            [
              ZStack(
                [
                  buildCoverHero(),
                  // chapterBox(null).positioned(bottom: 0, left: 0)
                ],
              ),
              3.height,
              buildNovelTitle(maxLines: 2, pRight: 4),
              // 4.width,
              (novel?.author ?? "")
                  .text
                  .sm
                  .ellipsis
                  .medium
                  .color(AppColor.redScarlet)
                  .make()
                  .flexible(),
            ],
            crossAlignment: CrossAxisAlignment.start,
          ).w(width),
        ).pOnly(left: index == 0 ? 0 : 4, bottom: 4);
      }
    } else {
      //CONTENT ON RIGHT

      return ZStack(
        [
          HStack(
            [
              buildCoverHero(),
              VStack([
                (author ?? novel?.author ?? "author")
                    .text
                    .color(AppColor.redScarlet)
                    .sm
                    .ellipsis
                    .make()
                    .flexible(),
                buildNovelTitle(),
                4.height,
                novel == null || novel?.genre == null
                    ? UiSpacer.emptySpace()
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            ...buildGenresBox(novel),
                          ],
                        ),
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
              .make()
              .pOnly(bottom: 8),
          buildChapterBox("${novel?.chapter ?? 0} Chapters")
              .positioned(top: 0, right: 0),
        ],
      ).onTap(onItemTap);
    }
  }

  //
  Widget buildNovelTitle({int maxLines = 1, double? pRight}) {
    return Flexible(
      child: (novel?.title ?? "Novel Placeholder")
          .text
          .size(13)
          .ellipsis
          .maxLines(maxLines)
          .bold
          .make()
          .pOnly(right: pRight ?? 0),
      // .expand(),
    );
  }

  //
  Widget buildCoverHero({double? width, double? height}) {
    return novel == null
        ? ImgCoverWidget(
            image: novel?.cover,
            widthCover: width ?? widthCover,
            heightCover: height ?? heightCover,
          )
        : Hero(
            tag: novel?.sectionId ?? "0",
            child: ImgCoverWidget(
              image: novel?.cover,
              widthCover: width ?? widthCover,
              heightCover: height ?? heightCover,
            ),
          );
  }

  Widget buildChapterBox(String? capter) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade400,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      child: (capter ?? '20 Chapter')
          .text
          .white
          .scale(0.75)
          .make()
          .pOnly(bottom: 1)
          .px(6)
          .py2(),
    );
  }

  buildGenresBox(Novel? model) {
    return model?.genre?.map((e) {
      return e.text.sm.gray500
          .make()
          .px4()
          .py1()
          .box
          .rounded
          .border(color: AppColor.fadedGrey)
          .make()
          .pOnly(right: 4);
    }).toList();
  }
}
