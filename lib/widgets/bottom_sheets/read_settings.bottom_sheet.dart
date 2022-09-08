import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/view_models/chapter.vm.dart';
import 'package:read_novel/view_models/read_novel.vm.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

Future<dynamic> readSettingsBottomSheet(BuildContext context, ChapterViewModel vm) {
  return showBarModalBottomSheet(
    expand: false,
    context: context,
    isDismissible: true,
    barrierColor: Colors.black38,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return VStack(
        [
          'Pengaturan'.text.bold.lg.make().center(),
          12.height,
          HStack(
            [
              HStack([...buildChooseBGColor(vm)]).expand(),
              HStack(
                [
                  const Icon(Icons.remove_circle_rounded).onTap(() => vm.handleFontSize(-1)),
                  Image.asset(AppIcons.textSize, width: 38,).px8(),
                  const Icon(Icons.add_circle_rounded).onTap(() => vm.handleFontSize(1)),
                ]
              )
            ],
          ).px8()
        ],
        crossAlignment: CrossAxisAlignment.stretch,
      ).py12().px4();
    },
  );
}

List<Widget> buildChooseBGColor(ChapterViewModel vm) {
  return AppColor.listChooseBgReadColor.map((e) {
    return CustomButton(
      onPressed: () => vm.handleBgColor(e),
      height: 20,
      shape: const CircleBorder(),
      shapeContainer: BoxShape.circle,
      color: e,
    ).w(50);
  }).toList();
}
