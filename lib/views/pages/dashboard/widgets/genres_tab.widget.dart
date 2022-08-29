import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/dashboard.vm.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:velocity_x/velocity_x.dart';

class GenresTabWidget extends StatelessWidget {
  const GenresTabWidget({Key? key, required this.vm}) : super(key: key);
  final DashboardViewModel vm;

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        VStack(
          List.generate(
            vm.genres?.length ?? 0,
            (index) {
              return HStack(
                [
                  UiSpacer.verticalDivider(),
                  (vm.genres?[index].name ?? 'Genre')
                      .text
                      .sm
                      .color(index == 0 ? Colors.black : Colors.grey)
                      .make(),
                ],
              ).pOnly(top: index == 0 ? 8 : Vx.dp24);
            },
          ),
        )
            .p16()
            .scrollVertical()
            .box
            .height(double.maxFinite)
            .color(AppColor.fadedGrey.withOpacity(0.3))
            .rightRounded(value: Vx.dp8)
            .make()
            .pOnly(top: Vx.dp8, bottom: Vx.dp8),
        VStack(
          [
            8.height,
            HStack(['Romances'.text.bold.size(12).make().p8()]),
            DynamicHeightGridView(
                itemCount: imgList.length,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                mainAxisSpacing: Vx.dp12,
                builder: (ctx, index) {
                  return NovelItem(
                    // image: imgList[index],
                    index: index,
                  );
                }).px8().expand(),
          ],
        ).expand(),
      ],
    );
  }
}
