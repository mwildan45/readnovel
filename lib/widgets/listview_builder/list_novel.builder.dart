import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/widgets/busy_indicator/novel_item.busy_indicator.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:velocity_x/velocity_x.dart';

class ListNovelBuilder extends StatelessWidget {
  const ListNovelBuilder({
    Key? key,
    this.label,
    this.isGridType = false,
    this.isVerticalList = false,
    this.itemBuilder,
    this.itemCount,
    this.labelTextSize,
    this.itemGrowable,
    this.onLoading = false,
    this.novel,
  }) : super(key: key);
  final String? label;
  final bool isGridType;
  final bool isVerticalList;
  final IndexedWidgetBuilder? itemBuilder;
  final int? itemCount;
  final double? labelTextSize;
  final List<Widget>? itemGrowable;
  final bool onLoading;
  final List<Novel>? novel;

  @override
  Widget build(BuildContext context) {
    return itemCount != 0
        ? VStack(
            [
              UiSpacer.verticalSpace(space: Vx.dp16),
              HStack(
                [
                  (label ?? 'label')
                      .text
                      .lg
                      .size(labelTextSize)
                      .color(AppColor.black)
                      .bold
                      .make()
                      .expand(),
                  "Lihat Semua".text.size(12).make()
                ],
              ),
              UiSpacer.verticalSpace(space: Vx.dp8),
              buildListView(),
            ],
          )
        : const SizedBox.shrink();
  }

  buildListView() {
    if (!isVerticalList) {
      //HORIZONTAL BUILDER

      if (!isGridType) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: HStack(
            itemCount == null || itemGrowable == null
                ? List.generate(
                    imgList.length,
                    (index) {
                      if (onLoading) {
                        return const BusyIndicatorNovelItem();
                      } else {
                        return NovelItem(
                          image: imgList[index],
                          index: index,
                          author: "Author ${index + 1}",
                        );
                      }
                    },
                  )
                : itemGrowable!,
            crossAlignment: CrossAxisAlignment.start,
          ),
        );
      } else {
        //GRIDVIEW BUILDER

        return DynamicHeightGridView(
          itemCount: itemCount ?? imgList.length,
          crossAxisCount: 2,
          crossAxisSpacing: Vx.dp12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: Vx.dp12,
          builder: onLoading
              ? (context, index) => const BusyIndicatorNovelItem(
                    height: 50,
                  )
              : itemBuilder ??
                  (ctx, index) {
                    return NovelItem(
                      image: imgList[index],
                      index: index,
                      height: 202,
                      widthCover: 100,
                      heightCover: 135,
                      author: 'author',
                      novelName: 'novel placeholder',
                      smallNovelItem: true,
                    );
                    // .p8()
                    // .box
                    // .color(AppColor.primaryColorDark.withOpacity(0.4))
                    // .withRounded(value: 5)
                    // .make();
                  },
        ).pOnly(right: Vx.dp8);
      }
    } else {
      //VERTICAL BUILDER

      return ListView.builder(
        shrinkWrap: true,
        primary: false,
        // scrollDirection: Axis.horizontal,
        itemCount: itemCount ?? imgList.length,
        itemBuilder: onLoading
            ? (context, index) => const BusyIndicatorNovelItem(height: 110,)
            : itemBuilder ??
                (context, index) {
                  return NovelItem(
                    image: imgList[index],
                    index: index,
                    author: "Author ${index + 1}",
                    isInfoOnRightPosition: true,
                  );
                },
      );
    }
  }
}
