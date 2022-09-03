import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/view_models/library.vm.dart';
import 'package:read_novel/widgets/busy_indicator/novel_item.busy_indicator.dart';
import 'package:read_novel/widgets/empty_list.widget.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:read_novel/widgets/list_items/history_novel.item.dart';
import 'package:velocity_x/velocity_x.dart';

class ListHistories extends StatelessWidget {
  const ListHistories(
      {Key? key, this.novel, this.onLoading = false, required this.vm})
      : super(key: key);
  final List<Novel>? novel;
  final bool onLoading;
  final LibraryViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        if(onLoading)
          ListView.separated(
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (context, index) {
              return const BusyIndicatorNovelItem(height: 135);
            },
            separatorBuilder: (context, index) => 5.height,
          ).expand()
        else if (novel == null || novel!.isEmpty)
          const EmptyListWidget(
            textEmpty: 'Riwayat anda kosong',
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
                return HistoryNovelItem(
                  index: index,
                  novel: novel?[index],
                  onItemTap: () => vm.openNovel(
                      vm.histories?[index].id, vm.histories?[index]),
                ).p2();
              }
            },
            separatorBuilder: (context, index) =>
                onLoading ? 5.height : Container(),
          ).expand()
      ],
    );
  }
}
