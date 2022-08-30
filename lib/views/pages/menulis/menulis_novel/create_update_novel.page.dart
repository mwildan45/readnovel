import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/write_novel.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/form_field/general.form_field.dart';
import 'package:read_novel/widgets/picker/image_novel_cover.picker.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateNovelPage extends StatelessWidget {
  const CreateNovelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WriteNovelViewModel>.reactive(
        viewModelBuilder: () => WriteNovelViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, vm, child) {
          return BasePage(
            activeContext: context,
            withAppBar: true,
            customAppBar: true,
            title: "Buat Novel Baru",
            body: SafeArea(
              child: SingleChildScrollView(
                child: VStack(
                  [
                    8.height,
                    ImageNovelCoverSelectorView(vm: vm),
                    UiSpacer.verticalSpace(),
                    Form(
                      key: vm.formKey,
                      child: VStack(
                        [
                          CustomTextFormField(
                            textEditingController: vm.novelName,
                            height: 48,
                            labelText: '* Nama Novel',
                            hintText: 'Tulis nama novel',
                            maxLines: 1,
                            radius: 10,
                          ),
                          12.height,
                          '* Peringkat Konten'.text.make().px8(),
                          vm.busy(vm.ages)
                              ? "-".text.make()
                              : Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    ...buildAges(vm),
                                  ],
                                ).p8(),
                          12.height,
                          '* Genre'.text.make().px8(),
                          vm.busy(vm.genres)
                              ? "-".text.make()
                              : Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    ...buildGenres(vm),
                                  ],
                                ).p8(),
                          12.height,
                          CustomTextFormField(
                            textEditingController: vm.synopsis,
                            hintText: 'Tulis sinopsis (maks 4000 huruf)',
                            labelText: 'Sinopsis',
                            maxLines: 5,
                            radius: 15,
                            maxLength: 4000,
                            verticalPadding: 8,
                            // validator: (val) => FormValidator.validateEmpty(val, errorTitle: 'Sinopsis'),
                          ).h(120),
                        ],
                      ),
                    ).px12(),
                    UiSpacer.verticalSpace(),
                    CustomButton(
                      height: 52,
                      isGradientColor: true,
                      loading: vm.isBusy,
                      shapeRadius: 30,
                      onPressed: () => vm.addOrUpdateNovel(vm),
                      title: 'Buat Sekarang',
                    ).w40(context),
                    UiSpacer.verticalSpace(),
                  ],
                  crossAlignment: CrossAxisAlignment.center,
                ),
              ),
            ),
          );
        });
  }

  buildAges(WriteNovelViewModel vm) {
    return vm.ages?.map((e) {
      return '${e.name}'
          .text
          .lg
          .color(
              vm.agesMap[e.id] == true ? AppColor.lotion : AppColor.fontColor)
          .make()
          .center()
          .box
          .withRounded(value: 8)
          .color(vm.agesMap[e.id] == true
              ? AppColor.cerisePink
              : AppColor.fadedGrey)
          .make()
          .w(80)
          .h(30)
          .onTap(() => vm.handleSelectAge(
              e.id, vm.agesMap[e.id] == true ? false : true));
    }).toList();
  }

  buildGenres(WriteNovelViewModel vm) {
    return vm.genres?.map((e) {
      return '${e.name}'
          .text
          .lg
          .color(
              vm.genresMap[e.id] == true ? AppColor.lotion : AppColor.fontColor)
          .make()
          .px8()
          .pOnly(top: 2)
          .box
          .withRounded(value: 8)
          .color(
              vm.genresMap[e.id] == true ? AppColor.cyan : AppColor.fadedGrey)
          .make()
          .h(30)
          .onTap(() => vm.handleSelectGenre(
              e.id, vm.genresMap[e.id] == true ? false : true));
    }).toList();
  }
}
