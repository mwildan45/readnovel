import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/services/validator.service.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/write_chapter.vm.dart';
import 'package:read_novel/view_models/write_novel.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/form_field/general.form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class WriteChapterPage extends StatelessWidget {
  const WriteChapterPage({Key? key, required this.data}) : super(key: key);
  final Map data;

  @override
  Widget build(BuildContext context) {
    var idNovel = data['idNovel'];
    var idChapter = data['idChapter'];
    var onUpdate = data['onUpdate'];

    print('--------- id novel $idNovel, id chapter $idChapter ---------');

    return ViewModelBuilder<WriteChapterViewModel>.reactive(
        viewModelBuilder: () =>
            WriteChapterViewModel(context, idNovel: idNovel),
        onModelReady: (model) => model.setInitTextEditingValue(idNovel,
            idChapter: idChapter, onUpdate: onUpdate),
        builder: (context, vm, child) {
          return BasePage(
            withAppBar: true,
            customAppBar: true,
            isLoading: vm.isBusy,
            activeContext: context,
            title: onUpdate ? "Perbarui Chapter" : "Tambah Chapter Baru",
            body: SafeArea(
              child: VStack(
                [
                  Expanded(
                    child: Form(
                      key: vm.formKey,
                      child: Scrollbar(
                        thickness: Vx.dp6,
                        child: SingleChildScrollView(
                          // physics: vm.chapterContent.processInputHtml ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              UiSpacer.verticalSpace(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      textEditingController: vm.chapterName,
                                      height: 48,
                                      labelText: '* Nama Chapter',
                                      hintText: 'Tulis nama chapter',
                                      maxLines: 1,
                                      radius: 10,
                                      validator: (val) =>
                                          FormValidator.validateEmpty(val,
                                              errorTitle: 'Nama Chapter'),
                                    ),
                                  ),
                                  8.width,
                                  CustomTextFormField(
                                    textEditingController: vm.chapterNumber,
                                    height: 48,
                                    labelText: 'Bab',
                                    hintText: 'Bab ke',
                                    maxLines: 1,
                                    radius: 10,
                                    keyboardType: TextInputType.number,
                                    validator: (val) =>
                                        FormValidator.validateEmpty(val,
                                            errorTitle: 'Bab'),
                                  ).w(80)
                                ],
                              ).px12(),
                              8.height,
                              VStack(
                                [
                                  QuillToolbar.basic(
                                    multiRowsDisplay: false,
                                    controller: vm.content,
                                    showColorButton: false,
                                    showCodeBlock: false,
                                    showListCheck: false,
                                    showSearchButton: false,
                                    showListBullets: false,
                                    showListNumbers: false,
                                    showLink: false,
                                  ),
                                  4.height,
                                  // UiSpacer.divider(color: AppColor.cerisePink).objectCenterRight().px16(),
                                  QuillEditor.basic(
                                    controller: vm.content,
                                    readOnly: false, // true for view only mode
                                  ),
                                  HStack([
                                    // 'minimal kata:'.text.italic.sm.gray400.make(),
                                    '${vm.countContent} Kata'
                                        .text.color(AppColor.cerisePink)
                                        .bold
                                        .sm
                                        .make()
                                  ]).objectCenterRight(),
                                ]
                              ).box.rounded.p8.border(color: AppColor.grey).make().px12(),
                              // HtmlEditor(
                              //   callbacks: Callbacks(
                              //     onEnter: (){
                              //       print('entered');
                              //     },
                              //     onChangeContent: (val){
                              //       print('entered ${val?.length}');
                              //     },
                              //   ),
                              //   controller: vm.chapterContent, //required
                              //   htmlEditorOptions: const HtmlEditorOptions(
                              //     hint: "mulai menulis....",
                              //     //initalText: "text content initial, if any",
                              //   ),
                              //   htmlToolbarOptions: const HtmlToolbarOptions(
                              //     defaultToolbarButtons: [
                              //       StyleButtons(),
                              //       FontButtons(),
                              //       ListButtons(),
                              //     ]
                              //   ),
                              //   otherOptions: OtherOptions(
                              //     height: double.maxFinite,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(15),
                              //       border: Border.all(color: AppColor.grey),
                              //     )
                              //   ),
                              // ).px12().h64(context),
                              4.height,
                              // HStack(
                              //   [
                              //     Checkbox(value: vm.locked, onChanged: vm.handleCheckbox),
                              //     // 8.width,
                              //     'Berbayar'.text.medium.make(),
                              //   ]
                              // ).px12(),
                              UiSpacer.verticalSpace(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Spacer(),
                  Row(
                    children: [
                      CustomButton(
                        height: 52,
                        color: AppColor.romanSilver,
                        loading: vm.busy(vm.chapterNumber),
                        shapeRadius: 30,
                        onPressed: () => vm.addNewAndUpdateChapter('draft',
                            idNovel: idNovel,
                            idChapter: idChapter,
                            onUpdate: onUpdate),
                        title: 'Draft',
                      ).w24(context).centered(),
                      Spacer(),
                      CustomButton(
                        height: 52,
                        isGradientColor: true,
                        loading: vm.busy(vm.chapterName),
                        shapeRadius: 30,
                        onPressed: () => vm.addNewAndUpdateChapter('publish',
                            idNovel: idNovel,
                            idChapter: idChapter,
                            onUpdate: onUpdate),
                        title: onUpdate ? 'Perbarui' : 'Terbitkan Sekarang',
                      ).w48(context).centered(),
                    ],
                  ).px12(),
                  12.height
                ],
              ),
            ),
          );
        });
  }
}
