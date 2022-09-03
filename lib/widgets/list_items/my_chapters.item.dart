import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/view_models/write_chapter.vm.dart';
import 'package:velocity_x/velocity_x.dart';

class MyChaptersItem extends StatelessWidget {
  const MyChaptersItem({Key? key, required this.vm, required this.index}) : super(key: key);
  final WriteChapterViewModel vm;
  final int index;

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        Icon(
          vm.chapters?[index].coin == 1 ? FontAwesomeIcons.lock : FontAwesomeIcons.lockOpen,
          color: vm.chapters?[index].coin == 1 ? Colors.yellowAccent : Colors.white,
          size: Vx.dp16,
        )
            .box
            .roundedFull
            .color(AppColor.unitedNationsBlue)
            .p8
            .make(),
        12.width,
        Expanded(
          child: VStack(
            [
              (vm.chapters?[index].title ?? "")
                  .text
                  .medium
                  .lg
                  .make(),
              "Bab ${(vm.chapters?[index].bab.toString() ?? " ")}"
                  .text.color(AppColor.romanSilver)
                  .sm
                  .make(),
            ],
          ),
        ),
        (vm.chapters?[index].status ?? "")
            .text
            .medium.white
            .make().center().py4()
            .box
            .rounded
            .color(vm.chapters?[index].status == "publish"
            ? AppColor.guppieGreen
            : AppColor.burlywood)
            .make().w16(context)
      ],
    )
        .px8().py12()
        .box
        .white
        .withRounded(value: 8)
        .outerShadowMd
        .shadowOutline(outlineColor: AppColor.grey)
        .make()
        .wFull(context)
        .pOnly(bottom: Vx.dp8);
  }
}
