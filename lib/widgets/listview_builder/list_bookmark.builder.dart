import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/view_models/library.vm.dart';
import 'package:read_novel/widgets/busy_indicator/novel_item.busy_indicator.dart';
import 'package:read_novel/widgets/empty_list.widget.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:velocity_x/velocity_x.dart';

class ListBookmarks extends StatelessWidget {
  const ListBookmarks(
      {Key? key, this.novel, this.onLoading = false, required this.vm})
      : super(key: key);
  final List<Novel>? novel;
  final bool onLoading;
  final LibraryViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack([
      if (novel == null || novel!.isEmpty)
        const EmptyListWidget(
          textEmpty: 'Bookmark anda kosong',
        )
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
                onItemTap: () =>
                    vm.openNovel(vm.bookmarks?[index].id, vm.bookmarks?[index]),
              ).p2();
            }
          },
          separatorBuilder: (context, index) =>
              onLoading ? 5.height : Container(),
        ).expand()
    ]);
  }
}
