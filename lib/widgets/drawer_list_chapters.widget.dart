import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/chapter.vm.dart';
import 'package:velocity_x/velocity_x.dart';

class DrawerListChaptersWidget extends StatelessWidget {
  const DrawerListChaptersWidget({Key? key, required this.vm})
      : super(key: key);
  final ChapterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Column(
          children: [
            UiSpacer.verticalSpace(),
            'Semua Bab'.text.bold.lg.center.make(),
            UiSpacer.verticalSpace(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: false,
                itemCount: vm.chapters?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: (vm.chapters?[index].title ?? "")
                        .text
                        .color(vm.indexChapter == index
                        ? AppColor.cerisePink
                        : AppColor.black)
                        .bold
                        .make(),
                    leading: "Bab ${(vm.chapters?[index].bab ?? 0).toString()}"
                        .text
                        .sm
                        .make(),
                  ).py4().onTap(() {
                    // vm.handleNavChapters(index);
                    vm.carouselController.jumpToPage(index);
                    context.pop();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
