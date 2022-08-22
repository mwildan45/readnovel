import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/widgets/img_cover.widget.dart';
import 'package:velocity_x/velocity_x.dart';

class NovelItem extends StatelessWidget {
  const NovelItem({
    Key? key,
    this.image,
    this.index,
    this.height = 170,
    this.width = 100,
    this.author,
    this.widthCover = 90,
    this.heightCover = 125,
    this.isInfoOnRightPosition = false,
    this.smallNovelItem = false,
    this.genres,
    this.novelName,
    this.onItemTap,
    this.idNovel,
    this.novel,
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

        return GestureDetector(
          onTap: onItemTap,
          child: HStack(
            [
              ZStack(
                [
                  buildCoverHero(
                    width: Vx.dp48,
                    height: Vx.dp48,
                  ),
                  // chapterBox(null).positioned(bottom: 0, left: 0)
                ],
              ),
              5.width,
              VStack(
                [
                  Flexible(
                    child:
                        (novelName != null ? novelName! : "Novel Placeholder")
                            .text
                            .size(13)
                            .ellipsis
                            .maxLines(1)
                            .bold
                            .make(),
                    // .expand(),
                  ),
                  3.height,
                  author == null
                      ? const SizedBox.shrink()
                      : '$author'
                          .text
                          .sm
                          .medium
                          .color(AppColor.redScarlet)
                          .make(),
                  genres == null
                      ? const SizedBox.shrink()
                      : 'Romance'.text.sm.gray500.make(),
                ],
                crossAlignment: CrossAxisAlignment.start,
              ).expand()
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).w(width),
        );
      } else {

        //CONTENT ON BELOW

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
              Flexible(
                child: (novelName != null ? novelName! : "Novel Placeholder")
                    .text
                    .size(13)
                    .align(TextAlign.start)
                    .ellipsis
                    .maxLines(2)
                    .bold
                    .make()
                    .pOnly(right: 8),
                // .expand(),
              ),
              // 2.height,
              author == null
                  ? const SizedBox.shrink()
                  : '$author'.text.sm.medium.color(AppColor.redScarlet).make(),
              genres == null
                  ? const SizedBox.shrink()
                  : 'Romance'.text.sm.gray500.make()
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
                '$author'.text.color(AppColor.redScarlet).sm.make(),
                Flexible(
                  child: (novelName != null ? novelName! : "Novel Placeholder")
                      .text
                      .size(13)
                      .ellipsis
                      .maxLines(1)
                      .bold
                      .make(),
                  // .expand(),
                ),
                4.height,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      ...buildGenresBox(novel),
                    ],
                  ),
                ),
                2.height,
                Flexible(
                  child: (novel?.sinopsis ?? 'no synopsis').text
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
          chapterBox("${novel?.chapter}").positioned(top: 0, right: 0),
        ],
      ).onTap(onItemTap);
    }
  }

  Widget buildCoverHero({double? width, double? height}) {
    return idNovel == null
        ? ImgCoverWidget(
            image: image,
            widthCover: width ?? widthCover,
            heightCover: height ?? heightCover,
          )
        : Hero(
            tag: idNovel!,
            child: ImgCoverWidget(
              image: image,
              widthCover: width ?? widthCover,
              heightCover: height ?? heightCover,
            ),
          );
  }

  Widget chapterBox(String? capter) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade400,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      child: (capter ?? '20 Chapter').text.white.scale(0.75).make().px(6).py2(),
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
          .make().pOnly(right: 4);
    }).toList();
  }
}
