import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hidable/hidable.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/read_novel.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class ReadNovelChapterPage extends StatelessWidget {
  const ReadNovelChapterPage({Key? key, required this.chapters})
      : super(key: key);
  final Chapters chapters;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReadNovelViewModel>.reactive(
      viewModelBuilder: () =>
          ReadNovelViewModel(context, idNovelChapter: chapters.id),
      onModelReady: (model) => model.getReadNovelChapter(),
      builder: (context, vm, child) {
        return BasePage(
          bottomNavigationBar: Hidable(
            controller: vm.scrollController,
            wOpacity: true, // As default it's true.
            size: 48,
            child: Column(
              children: [
                Container(
                  height: 42,
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(8),
                  child: HStack(
                    [
                      Image.asset(AppIcons.textSize, width: 22, height: 22,),
                      Image.asset(AppIcons.share, width: 22, height: 22,),
                    ],
                    alignment: MainAxisAlignment.spaceAround,
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: vm.busy(vm.read)
                ? Image.asset(AppGifs.bookLoading).centered()
                : VStack(
                    [
                      HStack(
                        [
                          const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: 18,
                          ).onTap(vm.backPressed),
                          ("${vm.read?.bab ?? "0"} | ${vm.read?.title ?? 'chapter title placeholder'}")
                              .text
                              .wide
                              .ellipsis
                              .fontWeight(FontWeight.w900)
                              .center
                              .make()
                              .expand(),
                        ],
                      ).px12().py12(),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: vm.scrollController,
                          child: VStack(
                            [
                              UiSpacer.verticalSpace(space: Vx.dp32),
                              HtmlWidget(
                                vm.read?.content ?? "no content",
                                textStyle: TextStyle(
                                  color: AppColor.fontColor
                                ),
                              )
                            ],
                          ).px12(),
                        ),
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }
}
