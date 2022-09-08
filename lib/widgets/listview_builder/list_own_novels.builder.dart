import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/view_models/library.vm.dart';
import 'package:read_novel/view_models/menu_menulis.vm.dart';
import 'package:read_novel/widgets/busy_indicator/novel_item.busy_indicator.dart';
import 'package:read_novel/widgets/empty_list.widget.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:velocity_x/velocity_x.dart';

class ListMyOwnNovels extends StatelessWidget {
  const ListMyOwnNovels(
      {Key? key, this.novel, this.onLoading = false, required this.vm})
      : super(key: key);
  final List<Novel>? novel;
  final bool onLoading;
  final MenuMenulisViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack([
      if (novel == null || onLoading)
        ListView.separated(
          shrinkWrap: true,
          // scrollDirection: Axis.horizontal,
          itemCount: novel?.length ?? imgList.length,
          itemBuilder: (context, index) {
            if (onLoading) {
              return const BusyIndicatorNovelItem(height: 135);
            } else {
              return NovelItem(
                index: index,
                novel: novel?[index],
                isInfoOnRightPosition: true,
                author: vm.profile?.username,
                onItemTap: () => vm.navUpdateNovel(novel?[index].id),
                withoutHeroAnimation: true,
              ).p2().pOnly(top: index == 0 ? 8 : 0);
            }
          },
          separatorBuilder: (context, index) =>
              onLoading ? 5.height : Container(),
        ).expand()
      else if(novel!.isEmpty)
        EmptyListWidget(
          textEmpty: 'Kamu belum menerbitkan apapun',
        ).center().expand()
      else
        ListView.separated(
          shrinkWrap: true,
          // scrollDirection: Axis.horizontal,
          itemCount: novel?.length ?? imgList.length,
          itemBuilder: (context, index) {
            if (onLoading) {
              return const BusyIndicatorNovelItem(height: 135);
            } else {
              return NovelItem(
                index: index,
                novel: novel?[index],
                isInfoOnRightPosition: true,
                author: vm.profile?.username,
                onItemTap: () => vm.navUpdateNovel(novel?[index].id),
                withoutHeroAnimation: true,
              ).p2().pOnly(top: index == 0 ? 8 : 0);
            }
          },
          separatorBuilder: (context, index) =>
          onLoading ? 5.height : Container(),
        ).expand()
    ]);
  }
}
