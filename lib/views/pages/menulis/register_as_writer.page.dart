import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/view_models/register_as_writer.vm.dart';
import 'package:read_novel/views/pages/menulis/register_step/confirm_data.page.dart';
import 'package:read_novel/views/pages/menulis/register_step/data_diri.page.dart';
import 'package:read_novel/views/pages/menulis/register_step/upload_foto.page.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterAsWriterPage extends StatefulWidget {
  const RegisterAsWriterPage({Key? key}) : super(key: key);

  @override
  State<RegisterAsWriterPage> createState() => _RegisterAsWriterPageState();
}

class _RegisterAsWriterPageState extends State<RegisterAsWriterPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterAsWriterViewModel>.reactive(
      viewModelBuilder: () => RegisterAsWriterViewModel(context),
      onModelReady: (model) {},
      builder: (context, vm, child) {
        return BasePage(
          body: SafeArea(
            child: PageView(
              controller: vm.pageViewController,
              onPageChanged: vm.onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                VStack(
                  [
                    UploadFotoPage(vm: vm).expand(),
                    buildButtonNav(vm)
                  ],
                ),
                VStack(
                  [
                    DataDiriPenulisPage(vm: vm,).expand(),
                    buildButtonNav(vm)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  buildButtonNav(vm) {
    return HStack(
      [
        CustomButton(
          onPressed: () => vm.onTabChange(vm.currentIndex - 1),
          title: 'Kembali',
        ).w(120).h(40),
        const Spacer(),
        CustomButton(
          onPressed: () => vm.onTabChange(vm.currentIndex + 1, vm: vm.currentIndex + 1 > 1 ? vm : null),
          color: AppColor.guppieGreen,
          title: 'Selanjutnya',
        ).w(120).h(40),
      ],
    ).px12().pOnly(bottom: Vx.dp12);
  }
}
