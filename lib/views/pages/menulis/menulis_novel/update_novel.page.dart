import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/services/validator.service.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/write_novel.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/form_field/general.form_field.dart';
import 'package:read_novel/widgets/picker/image_novel_cover.picker.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class UpdateNovelPage extends StatefulWidget {
  const UpdateNovelPage({Key? key, required this.idNovel}) : super(key: key);
  final int idNovel;

  @override
  State<UpdateNovelPage> createState() => _UpdateNovelPageState();
}

class _UpdateNovelPageState extends State<UpdateNovelPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WriteNovelViewModel>.reactive(
        viewModelBuilder: () => WriteNovelViewModel(context),
        onModelReady: (model) => model.getNovelDetail(widget.idNovel),
        builder: (context, vm, child) {
          return BasePage(
            activeContext: context,
            withAppBar: true,
            customAppBar: true,
            title: "Perbarui Novel",
            isLoading: vm.busy(vm.myNovelDetail),
            // onBackPressed: vm.onBackPressed,
            body: SafeArea(
              child: SingleChildScrollView(
                child: VStack(
                  [
                    8.height,
                    ImageNovelCoverSelectorView(
                        vm: vm, urlImage: vm.myNovelDetail?.cover),
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
                            validator: (val) => FormValidator.validateEmpty(val, errorTitle: 'Nama Novel'),
                          ),
                          12.height,
                          '* Peringkat Konten'.text.make().px8(),
                          vm.busy(vm.ages) || vm.ages == null
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
                          vm.busy(vm.genres) || vm.genres == null
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
                            validator: (val) => FormValidator.validateEmpty(val, errorTitle: 'Sinopsis'),
                          ).h(120),
                        ],
                      ),
                    ).px12(),
                    UiSpacer.verticalSpace(),
                    HStack(
                      [
                        // buildMenuAction(
                        //     icon: FontAwesomeIcons.trashCan,
                        //     label: 'Hapus Novel',
                        //     color: AppColor.redScarlet),
                        buildMenuAction(
                          icon: FontAwesomeIcons.listOl,
                          label: 'Daftar Bab',
                          onTap: () => vm.navShowAllChapter(widget.idNovel)
                        ),
                        buildMenuAction(
                            icon: Icons.refresh_rounded,
                            label: 'Perbarui Novel',
                            color: Colors.yellow.shade800,
                            onLoading: vm.isBusy,
                            onTap: () => vm.addOrUpdateNovel(vm,
                                onUpdate: true, idNovel: widget.idNovel)),
                      ],
                      alignment: MainAxisAlignment.spaceEvenly,
                    ).wFull(context),
                    // CustomButton(
                    //   height: 52,
                    //   isGradientColor: true,
                    //   loading: vm.isBusy,
                    //   shapeRadius: 30,
                    //   onPressed: () => vm.addNovel(vm),
                    //   title: 'Buat Sekarang',
                    // ).w40(context),
                    UiSpacer.verticalSpace(),
                  ],
                  crossAlignment: CrossAxisAlignment.center,
                ),
              ),
            ),
          );
        });
  }

  buildMenuAction(
      {required IconData icon,
      required String label,
      Function()? onTap,
      bool onLoading = false,
      Color? color}) {
    return InkWell(
      onTap: onLoading ? null : onTap,
      child: Column(
        children: [
          (onLoading ? const CircularProgressIndicator(color: Colors.white).w(25).h(25).centered() : Icon(
            icon,
            color: Colors.white,
          ))
              .box
              .color(color ?? AppColor.guppieGreen)
              .width(Vx.dp48).height(Vx.dp48)
              .shadowSm
              .withRounded(value: 8)
              .make(),
          6.height,
          label.text.bold.make()
        ],
      ),
    );
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
