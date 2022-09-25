import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidable/hidable.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/read_chapter.vm.dart';
import 'package:read_novel/widgets/bottom_read_config.widget.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/drawer_list_chapters.widget.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:stacked/stacked.dart';
import 'package:tuple/tuple.dart';
import 'package:velocity_x/velocity_x.dart';

class ReadNovelChapterPage extends StatefulWidget {
  const ReadNovelChapterPage(
      {Key? key,
      required this.idChapters,
      required this.detailNovel,
      required this.index})
      : super(key: key);
  final int idChapters;
  final DetailNovel detailNovel;
  final int? index;

  @override
  State<ReadNovelChapterPage> createState() => _ReadNovelChapterPageState();
}

class _ReadNovelChapterPageState extends State<ReadNovelChapterPage> {
  @override
  void dispose() {
    ReadChapterViewModel(context).disableScreenshot(onClose: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('detail novel id ${widget.detailNovel.id}');
    return ViewModelBuilder<ReadChapterViewModel>.reactive(
      viewModelBuilder: () => ReadChapterViewModel(context,
          idNovelChapter: widget.idChapters, detailNovel: widget.detailNovel),
      onModelReady: (model) => model.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          drawerMenu: vm.busy(vm.chapters)
              ? const SizedBox.shrink()
              : DrawerListChaptersWidget(
                  vm: vm,
                ),
          bodyBgColor: vm.selectedColor,
          bottomNavigationBar: vm.busy(vm.chapters)
              ? const SizedBox.shrink()
              : BottomReadConfigWidget(
                  vm: vm,
                ),
          body: SafeArea(
            child: vm.busy(vm.chapters)
                ? const SizedBox.shrink()
                : VStack(
                    [
                      Hidable(
                        controller: vm.scrollController[vm.indexChapter ?? 0],
                        child: HStack(
                          [
                            Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: vm.selectedColor == AppColor.black
                                  ? Colors.white
                                  : AppColor.black,
                              size: 18,
                            ).onTap(vm.backPressed),
                            ("${vm.read?.bab ?? "0"} | ${vm.read?.title ?? 'chapter title placeholder'}")
                                .text
                                .wide
                                .color(vm.selectedColor == AppColor.black
                                    ? Colors.white
                                    : AppColor.black)
                                .ellipsis
                                .fontWeight(FontWeight.w900)
                                .center
                                .make()
                                .expand(),
                          ],
                        ).px12().py12(),
                      ),
                      Expanded(
                        child: VStack(
                          [
                            UiSpacer.verticalSpace(space: Vx.dp20),
                            Builder(builder: (context) {
                              final double height =
                                  MediaQuery.of(context).size.height;
                              return CarouselSlider.builder(
                                itemCount: vm.chapters?.length ?? 0,
                                options: CarouselOptions(
                                  height: height,
                                  onPageChanged: (index, reason) {
                                    vm.handleNavChapters(index);
                                    print('id ${vm.chapters?[index].id}');
                                  },
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  enableInfiniteScroll: false,
                                  initialPage: widget.index ?? 0,
                                  // autoPlay: false,
                                ),
                                carouselController: vm.carouselController,
                                itemBuilder: (BuildContext context,
                                    int itemIndex, int pageViewIndex) {
                                  if (vm.busy(vm.read)) {
                                    return Image.asset(AppGifs.bookLoading)
                                        .centered();
                                  } else if (vm.failedGetContent) {
                                    return (vm.messageFailedToReadTheCh ?? "")
                                        .text
                                        .center
                                        .bold
                                        .make()
                                        .centered();
                                  } else {
                                    return SingleChildScrollView(
                                      controller: vm.scrollController[pageViewIndex],
                                      child: vm.inHtml
                                          ? HtmlWidget(
                                              vm.read?.content ?? "no content",
                                              textStyle: TextStyle(
                                                fontSize: vm.selectedFontSize.toDouble(),
                                                color: vm.selectedColor == AppColor.black
                                                    ? Colors.white
                                                    : AppColor.fontColor,
                                              ),
                                            )
                                          : QuillEditor(
                                              controller: vm.contentText,
                                              readOnly: true,
                                              scrollController: vm.scrollController[pageViewIndex],
                                              scrollable: false,
                                              focusNode: FocusNode(),
                                              autoFocus: false,
                                              expands: false,
                                              padding: EdgeInsets.zero,
                                              showCursor: false,
                                        customStyles: DefaultStyles(
                                          sizeSmall: TextStyle(
                                            fontSize: vm.selectedFontSize.toDouble(),
                                            color: vm.selectedColor == AppColor.black
                                                ? Colors.white
                                                : AppColor.fontColor,
                                          ),
                                          paragraph: DefaultTextBlockStyle(
                                              GoogleFonts.alata(
                                                fontSize: vm.selectedFontSize.toDouble(),
                                                color: vm.selectedColor == AppColor.black
                                                    ? Colors.white
                                                    : AppColor.fontColor,
                                              ),
                                              Tuple2(16, 0),
                                              Tuple2(0, 0),
                                              null
                                          )

                                        ),
                                            ).pOnly(bottom: Vx.dp24),
                                    );
                                  }
                                },
                              );
                            }).expand(),
                          ],
                        ).px12(),
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }
}
