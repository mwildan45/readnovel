import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
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
    this.isCenteredContent = false,
    this.genres,
    this.novelName,
    this.onItemTap,
  }) : super(key: key);
  final String? image;
  final int? index;
  final double width, height, widthCover, heightCover;
  final String? author;
  final String? genres;
  final String? novelName;
  final bool isInfoOnRightPosition;
  final bool isCenteredContent;
  final Function()? onItemTap;

  @override
  Widget build(BuildContext context) {
    if (!isInfoOnRightPosition) {
      //CONTENT ON BELOW
      return GestureDetector(
        onTap: onItemTap,
        child: VStack(
          [
            ZStack(
              [
                ImgCoverWidget(
                  image: image,
                  widthCover: widthCover,
                  heightCover: heightCover,
                ),
                chapterBox(null).positioned(bottom: 0, left: 0)
              ],
            ),
            3.height,
            Flexible(
              child: /*(novelName ?? "").split(p.extension(novelName ?? ""))[0]*/
                  "Novel Placeholder"
                      .text
                      .size(13)
                      .align(isCenteredContent
                          ? TextAlign.center
                          : TextAlign.start)
                      .ellipsis
                      .maxLines(2)
                      .bold
                      .make()
                      .pOnly(right: 8),
              // .expand(),
            ),
            2.height,
            author == null
                ? const SizedBox.shrink()
                : '$author'.text.sm.medium.color(AppColor.redScarlet).make(),
            genres == null
                ? const SizedBox.shrink()
                : 'Romance'.text.sm.gray500.make()
          ],
          crossAlignment: isCenteredContent
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
        ).w(width),
      ).pOnly(left: index == 0 ? 0 : 4, bottom: 4);
      // .p(6)
      // .box
      // .withRounded(value: 8)
      // .white
      // .outerShadowMd
      // .shadowOutline(outlineColor: AppColor.grey)
      // .make();
    } else {
      //CONTENT ON RIGHT
      return ZStack(
        [
          HStack(
            [
              Image.network(
                image ?? '',
                fit: BoxFit.cover,
              ).w(widthCover).h(heightCover).cornerRadius(8),
              VStack([
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
                4.height,
                // HStack(
                //   [
                //     HStack([
                //       Icon(
                //         FontAwesomeIcons.circleCheck,
                //         size: 11,
                //         color: Colors.white,
                //       ),
                //       3.width,
                //       'Complete'.text.scale(0.8).white.make()
                //     ])
                //         .p(3)
                //         .box
                //         .rounded
                //         .color(AppColor.lightMalachiteGreen)
                //         .make(),
                //     8.width,
                //     Icon(
                //       FontAwesomeIcons.solidEye,
                //       size: 12,
                //     ).center(),
                //     4.width,
                //     '32K'.text.black.scale(0.85).make().pOnly(top: 3)
                //   ],
                // ),
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
                Flexible(
                  child: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                          ' Quisque tincidunt nunc risus, vitae facilisis purus cursus vitae. Nullam ac augue vitae est ultrices rhoncus quis id lacus. '
                          'Curabitur nec volutpat mi. Integer in magna odio. Integer porttitor erat in vehicula tempor. Sed sed ex erat. Mauris quis lacus '
                          'quis arcu sagittis sodales. Vivamus mollis eget sem eu imperdiet. Phasellus vel sagittis quam, vel egestas nibh. In volutpat,'
                          ' libero eget fringilla feugiat, odio quam ultricies augue, eu condimentum urna ex quis arcu. Aliquam sit amet purus'
                          ' condimentum, auctor ipsum in, congue risus. Etiam ante arcu, imperdiet non enim et, ullamcorper cursus justo. Sed et lorem '
                          'venenatis, dapibus purus sit amet, malesuada '
                          'sapien. Quisque ornare finibus leo ullamcorper lacinia. Pellentesque fermentum mattis dolor, non dictum turpis dapibus quis.'
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
          chapterBox(null).positioned(top: 0, right: 0),
        ],
      );
    }
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
}
