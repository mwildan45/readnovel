import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_sizes.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/read_novel.vm.dart';
import 'package:read_novel/views/pages/read_novel/widgets/info_coverauthorgenres.widget.dart';
import 'package:read_novel/views/pages/read_novel/widgets/info_viewchapterupdate.widget.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/img_cover.widget.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailNovelPage extends StatefulWidget {
  const DetailNovelPage({Key? key}) : super(key: key);

  @override
  State<DetailNovelPage> createState() => _DetailNovelPageState();
}

class _DetailNovelPageState extends State<DetailNovelPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReadNovelViewModel>.reactive(
      viewModelBuilder: () => ReadNovelViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionWidget: CustomButton(
            title: "Mulai Membaca",
            height: 46,
            isGradientColor: true,
            shapeRadius: 30,
            onPressed: vm.openAvailableChapters,
          ).px20(),
          body: SafeArea(
            child: VStack(
              [
                HStack([
                  const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 18,
                  ),
                  'Ther Melian: Discord'
                      .text
                      .wide
                      .fontWeight(FontWeight.w900)
                      .center
                      .make()
                      .expand(),
                  const Icon(Icons.more_horiz_outlined)
                ]).px12().py12(),
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (Rect rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.85, 1]
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect
                          .height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: VStack(
                        [
                          InfoCoverAuthorGenresWidget(),
                          InfoViewChapterUpdateWIdget(),
                          UiSpacer.verticalSpace(space: Vx.dp16),
                          VStack(
                            [
                              'Sinopsis'.text.bold.size(13).make().objectCenterLeft(),
                              8.height,
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                  ' Quisque tincidunt nunc risus, vitae facilisis purus cursus vitae. Nullam ac augue vitae est ultrices rhoncus quis id lacus. '
                                  'Curabitur nec volutpat mi. Integer in magna odio. Integer porttitor erat in vehicula tempor. Sed sed ex erat. Mauris quis lacus '
                                  'quis arcu sagittis sodales. Vivamus mollis eget sem eu imperdiet. Phasellus vel sagittis quam, vel egestas nibh. In volutpat,'
                                  ' libero eget fringilla feugiat, odio quam ultricies augue, eu condimentum urna ex quis arcu. Aliquam sit amet purus'
                                  ' condimentum, auctor ipsum in, congue risus. Etiam ante arcu, imperdiet non enim et, ullamcorper cursus justo. Sed et lorem '
                                  'venenatis, dapibus purus sit amet, malesuada '
                                  'sapien. Quisque ornare finibus leo ullamcorper lacinia. Pellentesque fermentum mattis dolor, non dictum turpis dapibus quis.'
                                  .text.size(13).color(AppColor.romanSilver).make().objectCenterLeft(),
                            ],
                          ).px12().py12(),
                          UiSpacer.verticalSpace(space: Vx.dp64),
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
