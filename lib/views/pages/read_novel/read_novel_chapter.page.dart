import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hidable/hidable.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/read_novel.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class ReadNovelChapterPage extends StatefulWidget {
  const ReadNovelChapterPage({Key? key, required this.chapters, required this.detailNovel})
      : super(key: key);
  final Chapters chapters;
  final DetailNovel detailNovel;

  @override
  State<ReadNovelChapterPage> createState() => _ReadNovelChapterPageState();
}

class _ReadNovelChapterPageState extends State<ReadNovelChapterPage> {

  @override
  void dispose() {
    ReadNovelViewModel(context).disableScreenshot(onClose: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReadNovelViewModel>.reactive(
      viewModelBuilder: () =>
          ReadNovelViewModel(context, idNovelChapter: widget.chapters.id),
      onModelReady: (model) => model.getReadNovelChapter(),
      builder: (context, vm, child) {
        return BasePage(
          drawerMenu: Container(
            width: 220,
            color: AppColor.primaryColor,
            child: SafeArea(
              child: Column(
                children: [
                  UiSpacer.verticalSpace(),
                  'Semua Bab'.text.bold.lg.center.make(),
                  UiSpacer.verticalSpace(),
                  Expanded(
                    child: SideNavigationBar(
                      expandable: false,
                      theme: SideNavigationBarTheme(
                          itemTheme: SideNavigationBarItemTheme(selectedItemColor: AppColor.royalOrange, iconSize: 8),
                          togglerTheme: SideNavigationBarTogglerTheme.standard(),
                          dividerTheme: SideNavigationBarDividerTheme.standard(),
                          backgroundColor: Colors.white
                      ),
                      selectedIndex: 0,
                      items: List.generate(widget.detailNovel.chapters?.length ?? 0, (index) {
                        return SideNavigationBarItem(
                          icon: Icons.circle,
                          label: widget.detailNovel.chapters?[index].title ?? "",
                        );
                      }),
                      onTap: (int){
                        print('index $int');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bodyBgColor: vm.selectedColor,
          bottomNavigationBar: Hidable(
            controller: vm.scrollController,
            wOpacity: true, // As default it's true.
            size: 58,
            child: Container(
              height: 55,
              width: double.maxFinite,
              color: Colors.white,
              padding: const EdgeInsets.all(8),
              child: HStack(
                [
                  Builder(
                    builder: (context) {
                      return const Icon(FontAwesomeIcons.listUl).onTap(() => Scaffold.of(context).openDrawer());
                    }
                  ),
                  Image.asset(AppIcons.settings, width: 25, height: 25,).w(50).onTap(() => vm.openReadSetting(vm)),
                  Image.asset(AppIcons.share, width: 25, height: 25,),
                ],
                alignment: MainAxisAlignment.spaceAround,
              ),
            ).box.shadowLg.make(),
          ),
          body: SafeArea(
            child: vm.busy(vm.read)
                ? Image.asset(AppGifs.bookLoading).centered()
                : VStack(
                    [
                      Hidable(
                        controller: vm.scrollController,
                        child: HStack(
                          [
                            Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: vm.selectedColor == AppColor.black ? Colors.white : AppColor.black,
                              size: 18,
                            ).onTap(vm.backPressed),
                            ("${vm.read?.bab ?? "0"} | ${vm.read?.title ?? 'chapter title placeholder'}")
                                .text
                                .wide.color(vm.selectedColor == AppColor.black ? Colors.white : AppColor.black)
                                .ellipsis
                                .fontWeight(FontWeight.w900)
                                .center
                                .make()
                                .expand(),
                          ],
                        ).px12().py12(),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: vm.scrollController,
                          child: VStack(
                            [
                              UiSpacer.verticalSpace(space: Vx.dp32),
                              HtmlWidget(
                                vm.read?.content ?? "no content",
                                textStyle: TextStyle(
                                  fontSize: vm.selectedFontSize.toDouble(),
                                  color: vm.selectedColor == AppColor.black ? Colors.white : AppColor.fontColor,
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
