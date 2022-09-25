import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hidable/hidable.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/view_models/read_chapter.vm.dart';
import 'package:read_novel/view_models/read_novel.vm.dart';
import 'package:velocity_x/velocity_x.dart';

class BottomReadConfigWidget extends StatelessWidget {
  const BottomReadConfigWidget({Key? key, required this.vm}) : super(key: key);
  final ReadChapterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Hidable(
      controller: vm.scrollController[vm.indexChapter ?? 0],
      wOpacity: true, // As default it's true.
      size: 58,
      child: Container(
        height: 55,
        width: double.maxFinite,
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: HStack(
          [
            Builder(builder: (context) {
              return const Icon(FontAwesomeIcons.listUl)
                  .onTap(() => Scaffold.of(context).openDrawer());
            }),
            Image.asset(
              AppIcons.settings,
              width: 25,
              height: 25,
            ).w(50).onTap(() => vm.openReadSetting(vm)),
            // Image.asset(
            //   AppIcons.share,
            //   width: 25,
            //   height: 25,
            // ),
          ],
          alignment: MainAxisAlignment.spaceAround,
        ),
      ).box.shadowLg.make(),
    );
  }
}
