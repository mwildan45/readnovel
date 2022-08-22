import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class UploadFotoPage extends StatelessWidget {
  const UploadFotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppImages.appLogoHorizontal).w(180).center().pOnly(top: Vx.dp24),
        Center(
          child: VStack(
            [
              'Upload Foto Identitas Kamu'.text.bold.make().centered(),
              UiSpacer.verticalSpace(),
              const Icon(FontAwesomeIcons.image).box.border(color: AppColor.fadedGrey).rounded.width(210).height(130).make().centered(),
              8.height,
              'harap mengupload foto identitas (ktp/paspor/sim)\nyang benar dan berlaku'.text.sm.center.italic.gray500.make().centered(),
              UiSpacer.verticalSpace(space: Vx.dp48),
            ]
          ),
        ).expand(),
      ],
    );
  }
}
