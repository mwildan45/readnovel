import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_images.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/menulis.vm.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class MenulisPage extends StatefulWidget {
  const MenulisPage({Key? key}) : super(key: key);

  @override
  State<MenulisPage> createState() => _MenulisPageState();
}

class _MenulisPageState extends State<MenulisPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenulisViewModel>.reactive(
      viewModelBuilder: () => MenulisViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, vm, child) {
        return SafeArea(
          child: Column(
            children: [
              12.height,
              Image.asset(AppImages.appLogoHorizontal).w(130).objectCenterLeft().pOnly(left: 12),
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
                          ..onTap = () {
                            print("Tap recognizer to print this sentence.");
                          },
                        style: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
                      ),
                    ],
                    defaultStyle: TextStyle(fontSize: 11, color: Colors.black.withOpacity(0.7)),
                    textAlign: TextAlign.center,
                  ),
                  UiSpacer.verticalSpace(),
                  'Sudah siap untuk jadi penulis?'.text.bold.lg.make().centered(),
                  8.height,
                  CustomButton(
                    onPressed: vm.openBecomeWriter,
                    title: 'Daftar',
                    shapeRadius: 1000,
                  ).w(150).h(38).centered(),
                  8.height
                ],
              )
                  .box
                  .rounded
                  .outerShadowMd
                  .shadowOutline(outlineColor: AppColor.grey)
                  .white
                  .p8
                  .make()
                  .px12()
                  .centered().expand(),
            ],
          ),
        );
      },
    );
  }
}
