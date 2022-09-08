import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/chapter.vm.dart';
import 'package:read_novel/view_models/read_novel.vm.dart';
import 'package:read_novel/widgets/card_image/img_cover.widget.dart';
import 'package:read_novel/widgets/listview_builder/list_chapters.builder.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

Future<dynamic> chaptersBottomSheet({
  required BuildContext context,
  required DetailNovel detailNovel,
}) {
  return showBarModalBottomSheet(
    expand: false,
    context: context,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return ViewModelBuilder<ChapterViewModel>.reactive(
        viewModelBuilder: () =>
            ChapterViewModel(context, idNovelChapter: detailNovel.id, detailNovel: detailNovel),
        onModelReady: (model) => model.getNovelChaptersList(),
        builder: (context, vm, child) {
          return VStack(
            [
              HStack(
                [
                  ImgCoverWidget(
                    image: detailNovel.cover,
                    widthCover: 42,
                    heightCover: 52,
                  ),
                  8.width,
                  VStack([
                    '${detailNovel.title}'.text.make(),
                    4.height,
                    '${detailNovel.chapter} Bab | ${detailNovel.status}'
                        .text
                        .sm
                        .make(),
                  ]).expand()
                ],
              )
                  .px16()
                  .pOnly(top: 16, bottom: 10)
                  .box
                  .color(AppColor.fadedGrey)
                  .make(),
              Flexible(
                child: ListChaptersBuilder(
                  vm: vm,
                  detailNovel: detailNovel,
                ).py4(),
              ),
              const Divider(),
              UiSpacer.verticalSpace()
            ],
          );
        },
      );
    },
  );
}
