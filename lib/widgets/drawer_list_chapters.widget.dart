import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/read_chapter.vm.dart';
import 'package:velocity_x/velocity_x.dart';

class DrawerListChaptersWidget extends StatelessWidget {
  const DrawerListChaptersWidget({Key? key, required this.vm})
      : super(key: key);
  final ReadChapterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
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
                  return Row(
                    children: [
                      "Bab ${(vm.chapters?[index].bab ?? 0).toString()}"
                          .text
                          .sm
                          .make().w(42),
                      8.width,
                      (vm.chapters?[index].title ?? "")
                          .text.lg
                          .color(vm.indexChapter == index
                          ? AppColor.cerisePink
                          : AppColor.black)
                          .bold
                          .make().expand(),
                      8.width,
                      if (vm.chapters![index].isLocked!)
                        Icon(
                          Icons.lock,
                          size: 18,
                          color: AppColor.royalOrange,
                        )
                    ],
                  ).px8()
                    /*ListTile(
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
                  )*/.py12().onTap(() {
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
