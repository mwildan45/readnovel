import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_sizes.dart';
import 'package:read_novel/widgets/img_cover.widget.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:velocity_x/velocity_x.dart';

Future<dynamic> chaptersBottomSheet(BuildContext context) {
  return showBarModalBottomSheet(
    expand: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return VStack(
        [
          HStack(
            [
              ImgCoverWidget(
                image: imgList[2],
                widthCover: 42,
                heightCover: 52,
              ),
              8.width,
              VStack([
                'Ther Melian: Discord'.text.make(),
                4.height,
                '24 Bab | Ongoing'.text.sm.make(),
              ]).expand()
            ],
          ).px16().pOnly(top: 16, bottom: 10).box.color(AppColor.fadedGrey).make(),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 15,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (context, index) {
                return HStack(
                  [
                    'Chapter ${index + 1}'.text.color(AppColor.fontColor).make().expand(),
                    if(index > 6)
                      Icon(
                        Icons.lock, size: 18, color: AppColor.royalOrange,
                      )
                  ],
                ).px12().py8();
              },
            ).py4(),
          )
        ],
      );
    },
  );
}
