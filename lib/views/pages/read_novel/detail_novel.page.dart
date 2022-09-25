import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_sizes.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/read_chapter.vm.dart';
import 'package:read_novel/view_models/read_novel.vm.dart';
import 'package:read_novel/views/pages/read_novel/widgets/info_coverauthorgenres.widget.dart';
import 'package:read_novel/views/pages/read_novel/widgets/info_viewchapterupdate.widget.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/busy_indicator/paragraph.busy_indicator.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailNovelPage extends StatefulWidget {
  const DetailNovelPage({Key? key, this.id, this.novel}) : super(key: key);
  final int? id;
  final Novel? novel;

  @override
  State<DetailNovelPage> createState() => _DetailNovelPageState();
}

class _DetailNovelPageState extends State<DetailNovelPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReadNovelViewModel>.reactive(
      viewModelBuilder: () => ReadNovelViewModel(context, idNovel: widget.novel!.id!),
      onModelReady: (model) => model.getNovelDetail(),
      builder: (context, vm, child) {
        return BasePage(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionWidget: Row(
            children: [
              CustomButton(
                title: "Mulai Membaca",
                height: 50,
                isGradientColor: true,
                shapeRadius: 30,
                onPressed: () => ReadChapterViewModel(context, detailNovel: vm.detailNovel).openAvailableChapters(),
              ).expand(),
              CustomButton(
                onPressed: vm.handleBookmark,
                loading: vm.busy(vm.isBookmarked),
                shape: const CircleBorder(),
                shapeContainer: BoxShape.circle,
                color: AppColor.redScarlet,
                icon: vm.isBookmarked ? FontAwesomeIcons.solidCircleCheck : FontAwesomeIcons.solidBookmark,
              )
            ],
          ).px12(),
          body: SafeArea(
            child: VStack(
              [
                HStack(
                  [
                    const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 18,
                    ).onTap(vm.backPressed),
                    (widget.novel?.title ?? 'Novel Placeholder')
                        .text
                        .wide
                        .fontWeight(FontWeight.w900)
                        .center
                        .make().px8()
                        .expand(),
                    const Icon(Icons.share, size: Vx.dp20,).onTap(vm.onShareNovel)
                  ],
                ).px12().py12(),
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (Rect rect) {
                      return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                              stops: [0.85, 1])
                          .createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: VStack(
                        [
                          InfoCoverAuthorGenresWidget(
                            detailNovel: vm.detailNovel,
                            id: widget.novel!.sectionId!,
                            novel: widget.novel,
                          ),
                          InfoViewChapterUpdateWIdget(
                            data: vm.detailNovel,
                          ),
                          UiSpacer.verticalSpace(space: Vx.dp12),
                          VStack(
                            [
                              'Sinopsis'
                                  .text
                                  .bold
                                  .size(13)
                                  .make()
                                  .objectCenterLeft(),
                              8.height,
                              vm.busy(vm.detailNovel)
                                  ? const ParagraphBusyIndicator(
                                      lines: 8,
                                    )
                                  : (vm.detailNovel?.synopsis ?? 'no synopsis...')
                                      .text
                                      .size(13)
                                      .color(AppColor.romanSilver)
                                      .make()
                                      .objectCenterLeft(),
                            ],
                          ).px12().py12(),
                          UiSpacer.verticalSpace(
                              space: AppSizes.appSynopsisBottomHeight),
                        ],
                        crossAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
