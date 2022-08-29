import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/register_as_writer.vm.dart';
import 'package:read_novel/widgets/picker/image_ktp.picker.dart';
import 'package:velocity_x/velocity_x.dart';

class UploadFotoPage extends StatelessWidget {
  const UploadFotoPage({Key? key, required this.vm}) : super(key: key);
  final RegisterAsWriterViewModel vm;

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
              ImageKTPSelectorView(vm: vm),
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
