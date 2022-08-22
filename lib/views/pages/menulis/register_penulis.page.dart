import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/menulis.vm.dart';
import 'package:read_novel/views/pages/menulis/register_step/data_diri.page.dart';
import 'package:read_novel/views/pages/menulis/register_step/upload_foto.page.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/form_field/general.form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPenulisPage extends StatefulWidget {
  const RegisterPenulisPage({Key? key}) : super(key: key);

  @override
  State<RegisterPenulisPage> createState() => _RegisterPenulisPageState();
}

class _RegisterPenulisPageState extends State<RegisterPenulisPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenulisViewModel>.reactive(
      viewModelBuilder: () => MenulisViewModel(context),
      onModelReady: (model) {},
      builder: (context, vm, child) {
        return BasePage(
          floatingActionWidget: HStack(
            [
              CustomButton(
                onPressed: () => vm.onTabChange(vm.currentIndex - 1),
                title: 'Kembali',
              ).w(120).h(40),
              const Spacer(),
              CustomButton(
                onPressed: () => vm.onTabChange(vm.currentIndex + 1),
                color: AppColor.lightMalachiteGreen,
                title: 'Selanjutnya',
              ).w(120).h(40),
            ],
          ).px8(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
            child: PageView(
              controller: vm.pageViewController,
              onPageChanged: vm.onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                UploadFotoPage(),
                DataDiriPenulisPage()
              ],
            ),
          ),
        );
      },
    );
  }
}
