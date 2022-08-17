import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:velocity_x/velocity_x.dart';

class ListNovelBuilder extends StatelessWidget {
  const ListNovelBuilder({
    Key? key,
    this.label,
    this.isGridType = false,
    this.isVerticalList = false, this.itemBuilder, this.itemCount, this.labelTextSize,
  }) : super(key: key);
  final String? label;
  final bool isGridType;
  final bool isVerticalList;
  final IndexedWidgetBuilder? itemBuilder;
  final int? itemCount;
  final double? labelTextSize;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        UiSpacer.verticalSpace(space: Vx.dp16),
        HStack(
          [
            (label ?? 'label').text.lg.size(labelTextSize).bold.make().expand(),
            "Lihat Semua".text.size(12).make()
          ],
        ),
        UiSpacer.verticalSpace(space: Vx.dp8),
        if(!isVerticalList)
          if (!isGridType)

            //HORIZONTAL VIEW LIST

            SizedBox(
              height: 170,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: itemCount ?? imgList.length,
                itemBuilder: itemBuilder ?? (context, index) {
                  return NovelItem(
                    image: imgList[index],
                    index: index,
                  );
                },
              ),
            )
          else

            //GRIDVIEW 2 ITEM LIST

            DynamicHeightGridView(
                itemCount: 4,
                crossAxisCount: 2,
                crossAxisSpacing: Vx.dp12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: Vx.dp12,
                builder: (ctx, index) {
                  return NovelItem(
                    image: imgList[index],
                    index: index,
                    height: 202,
                    widthCover: 100,
                    heightCover: 135,
                    author: "Author ${index + 1}",
                    isCenteredContent: true,
                  )
                      .p8()
                      .box
                      .color(AppColor.primaryColorDark.withOpacity(0.4))
                      .withRounded(value: 5)
                      .make();
                }).pOnly(right: Vx.dp8)
        else

          //VERTICAL VIEW LIST

          ListView.builder(
            shrinkWrap: true,
            primary: false,
            // scrollDirection: Axis.horizontal,
            itemCount: imgList.length,
            itemBuilder: (context, index) {
              return NovelItem(
                image: imgList[index],
                index: index,
                author: "Author ${index + 1}",
                isInfoOnRightPosition: true,
              );
            },
          )
      ],
    );
  }
}
