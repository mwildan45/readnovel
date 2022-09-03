import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/menu_menulis.vm.dart';
import 'package:read_novel/view_models/register_as_writer.vm.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/card_image/img_profile.widget.dart';
import 'package:read_novel/widgets/listview_builder/list_histories.builder.dart';
import 'package:read_novel/widgets/listview_builder/list_own_novels.builder.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class MenulisMenuPage extends StatefulWidget {
  const MenulisMenuPage({Key? key}) : super(key: key);

  @override
  State<MenulisMenuPage> createState() => _MenulisMenuPageState();
}

class _MenulisMenuPageState extends State<
    MenulisMenuPage> /*with AutomaticKeepAliveClientMixin<MenulisMenuPage>*/ {
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return ViewModelBuilder<MenuMenulisViewModel>.reactive(
      viewModelBuilder: () => MenuMenulisViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, vm, child) {
        return SafeArea(
          child: Column(
            children: [
              if (vm.isBusy)
                Center(
                  child: Image.asset(
                    AppImages.appLogoOnly,
                    width: 80,
                  ).centered(),
                ).expand()
              else if (vm.levelUser != 0)
                VStack(
                  [
                    Column(
                      children: [
                        12.height,
                        Image.asset(AppImages.appLogoHorizontal)
                            .w(130)
                            .objectCenterLeft()
                            .pOnly(left: 12),
                        10.height,
                        const ImageProfileWidget(radius: 30),
                        "${vm.profile?.username}".text.bold.xl.make(),
                        UiSpacer.verticalSpace(space: Vx.dp16),
                        CustomButton(
                          height: 32,
                          title: "Tulis Novel Baru",
                          isGradientColor: true,
                          shapeRadius: 30,
                          onPressed: vm.navCreateNovel,
                        ).w(178),
                      ],
                    )
                        .pOnly(bottom: Vx.dp24)
                        .box
                        .color(AppColor.ghostWhite2)
                        .bottomRounded(value: 30)
                        .make(),
                    8.height,
                    "Novel Saya".text.bold.xl.make().center(),
                    // UiSpacer.verticalSpace(),
                    ListMyOwnNovels(
                      vm: vm,
                      novel: vm.novel,
                      onLoading: vm.busy(vm.novel),
                    ).px12().expand()
                    // ListHistories(vm: ,).px8().expand()
                  ],
                ).expand()
              else
                buildRegisterAsWriterDialog(vm).expand(),
            ],
          ),
        );
      },
    );
  }

  Widget buildRegisterAsWriterDialog(MenuMenulisViewModel vm) {
    return VStack(
      [
        12.height,
        Image.asset(AppImages.appLogoHorizontal)
            .w(130)
            .objectCenterLeft()
            .pOnly(left: 12),
        10.height,
        VStack(
          [
            Image.asset(AppImages.writerVector).w(180).centered(),
            EasyRichText(
              "Sebelum memulai, silahkan baca terlebih dahulu panduan dalam menulis di aplikasi ReadNovel.\nBaca disini",
              patternList: [
                EasyRichTextPattern(
                  targetString: 'blue',
                  style: const TextStyle(color: Colors.blue),
                ),
                EasyRichTextPattern(
                  targetString: 'ReadNovel',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                EasyRichTextPattern(
                  targetString: 'Baca disini',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => vm.navPusatBantuanPage(),
                  style: const TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ],
              defaultStyle:
                  TextStyle(fontSize: 11, color: Colors.black.withOpacity(0.7)),
              textAlign: TextAlign.center,
            ),
            UiSpacer.verticalSpace(),
            'Sudah siap untuk jadi penulis?'.text.bold.lg.make().centered(),
            8.height,
            CustomButton(
              onPressed: vm.navBecomeWriter,
              title: 'Daftar',
              shapeRadius: 1000,
            ).w(150).h(38).centered(),
            10.height
          ],
        )
            .box
            .rounded
            .outerShadowMd
            .shadowOutline(outlineColor: AppColor.grey)
            .white
            .p8
            .make()
            .px16()
            .centered()
            .expand(),
      ],
    );
  }

// @override
// bool get wantKeepAlive => true;
}
