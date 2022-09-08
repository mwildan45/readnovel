import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/view_models/chapter.vm.dart';
import 'package:read_novel/widgets/busy_indicator/novel_item.busy_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class ListChaptersBuilder extends StatelessWidget {
  const ListChaptersBuilder(
      {Key? key, required this.vm, required this.detailNovel})
      : super(key: key);
  final ChapterViewModel vm;
  final DetailNovel detailNovel;

  @override
  Widget build(BuildContext context) {
    if (vm.busy(vm.chapters)) {
      return ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return const BusyIndicatorNovelItem(
            height: 50,
          );
        },
        separatorBuilder: (BuildContext context, int index) => 8.height,
        itemCount: 8,
      );
    } else {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: vm.chapters?.length ?? 0,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          return HStack(
            [
              '${vm.chapters?[index].title}'
                  .text
                  .color(AppColor.fontColor)
                  .make()
                  .expand(),
              if (vm.chapters![index].isLocked!)
                Icon(
                  Icons.lock,
                  size: 18,
                  color: AppColor.royalOrange,
                )
            ],
          ).px12().py8().onTap(
                () =>
                    vm.startToReadTheChapter(chapters: vm.chapters![index], detailNovel: detailNovel, index: index),
              );
        },
      );
    }
  }
}
