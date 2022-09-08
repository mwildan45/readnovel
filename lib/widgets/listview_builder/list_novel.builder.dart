import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
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
    this.onTapSeeAll,
    this.noLabel = false,
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
  final Function()? onTapSeeAll;
  final bool noLabel;

  @override
  Widget build(BuildContext context) {
    return itemCount != 0
        ? VStack(
            [
              noLabel
                  ? UiSpacer.emptySpace()
                  : VStack([
                      UiSpacer.verticalSpace(space: Vx.dp24),
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
                          "Lihat Semua".text.size(12).make().onTap(onTapSeeAll)
                        ],
                      ),
                    ]),
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
          child: Builder(builder: (context) {
            if (onLoading) {
              return HStack(
                List.generate(
                  8,
                  (index) {
                    return const BusyIndicatorNovelItem();
                  },
                ),
                crossAlignment: CrossAxisAlignment.start,
              );
            } else if (itemCount == null || itemGrowable == null) {
              return HStack(
                List.generate(
                  imgList.length,
                  (index) {
                    return NovelItem(
                      index: index,
                    );
                  },
                ),
                crossAlignment: CrossAxisAlignment.start,
              );
            } else {
              return HStack(itemGrowable!,
                  crossAlignment: CrossAxisAlignment.start);
            }
          }),
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
                    height: 78,
                    width: 68,
                    minHeight: 78,
                  )
              : itemBuilder ??
                  (ctx, index) {
                    return NovelItem(
                      index: index,
                      height: 202,
                      widthCover: 100,
                      heightCover: 135,
                      smallNovelItem: true,
                    );
                  },
        ).pOnly(right: Vx.dp8);
      }
    } else {
      //VERTICAL BUILDER

      return ListView.separated(
        shrinkWrap: true,
        primary: false,
        // scrollDirection: Axis.horizontal,
        itemCount: itemCount ?? imgList.length,
        itemBuilder: onLoading
            ? (context, index) => const BusyIndicatorNovelItem(
                  height: 135,
                )
            : itemBuilder ??
                (context, index) {
                  return NovelItem(
                    index: index,
                    isInfoOnRightPosition: true,
                  );
                },
        separatorBuilder: (context, index) => 8.height,
      );
    }
  }
}
