import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/read_novel.vm.dart';
import 'package:read_novel/widgets/card_image/img_cover.widget.dart';
import 'package:velocity_x/velocity_x.dart';

Future<dynamic> chaptersBottomSheet(BuildContext context, DetailNovel data, ReadNovelViewModel viewModel) {
  print('data ${data.title}');
  return showBarModalBottomSheet(
    expand: false,
    context: context,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return VStack(
        [
          HStack(
            [
              ImgCoverWidget(
                image: data.cover,
                widthCover: 42,
                heightCover: 52,
              ),
              8.width,
              VStack([
                '${data.title}'.text.make(),
                4.height,
                '${data.chapter} Bab | ${data.status}'.text.sm.make(),
              ]).expand()
            ],
          ).px16().pOnly(top: 16, bottom: 10).box.color(AppColor.fadedGrey).make(),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: data.chapters?.length ?? 0,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (context, index) {
                return HStack(
                  [
                    '${data.chapters?[index].title}'.text.color(AppColor.fontColor).make().expand(),
                    if(data.chapters![index].isLocked!)
                      Icon(
                        Icons.lock, size: 18, color: AppColor.royalOrange,
                      )
                  ],
                ).px12().py8().onTap(() => viewModel.startToReadTheChapter(data.chapters![index], data));
              },
            ).py4(),
          ),
          const Divider(),
          UiSpacer.verticalSpace()
        ],
      );
    },
  );
}
