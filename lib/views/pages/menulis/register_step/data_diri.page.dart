import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_images.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/widgets/form_field/general.form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class DataDiriPenulisPage extends StatelessWidget {
  const DataDiriPenulisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: VStack(
          [
            UiSpacer.verticalSpace(),
            Image.asset(AppImages.appLogoOnly).w(50).h(50),
            8.height,
            'Satu langkah lagi untuk menjadi penulis!'.text.bold.lg.center.make(),
            UiSpacer.verticalSpace(space: Vx.dp24),
            // CircleAvatar(radius: 40),
            8.height,
            CustomTextFormField(
              height: 40,
              hintText: 'Nama Sebenarnya',
              maxLines: 1,
            ),
            4.height,
            CustomTextFormField(
              height: 40,
              hintText: 'Umur',
              maxLines: 1,
            ),
            4.height,
            CustomTextFormField(
              height: 40,
              hintText: 'No Identitas (KTP/Paspor/SIM)',
              maxLines: 1,
            ),
            4.height,
            CustomTextFormField(
              hintText: 'Alamat',
              maxLines: 3,
              radius: 15,
            ),
            4.height,
            CustomTextFormField(
              height: 40,
              hintText: 'Email',
              maxLines: 1,
            ),
            4.height,
            CustomTextFormField(
              height: 40,
              hintText: 'No. Telp',
              maxLines: 1,
            ),
            4.height,
            CustomTextFormField(
              height: 40,
              hintText: 'Facebook',
              maxLines: 1,
            ),
            6.height,
            '*harap mengisi seluruh data dengan benar'.text.cyan500.sm.make().objectCenterLeft(),
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).w(double.maxFinite).px32(),
      ),
    );
  }
}
