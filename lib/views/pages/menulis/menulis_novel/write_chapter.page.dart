import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/write_novel.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/form_field/general.form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class WriteChapterPage extends StatelessWidget {
  const WriteChapterPage({Key? key, required this.viewModel}) : super(key: key);
  final WriteNovelViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WriteNovelViewModel>.reactive(
        viewModelBuilder: () => WriteNovelViewModel(context),
        onModelReady: (model) {},
        builder: (context, vm, child) {
        return BasePage(
          withAppBar: true,
          customAppBar: true,
          activeContext: context,
          title: "Tambah Chapter Baru",
          body: SafeArea(
            child: VStack(
              [
                Expanded(
                  child: SingleChildScrollView(
                    // physics: vm.chapterContent.processInputHtml ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        UiSpacer.verticalSpace(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                textEditingController: vm.chapterName,
                                height: 48,
                                labelText: '* Nama Chapter',
                                hintText: 'Tulis nama chapter',
                                maxLines: 1,
                                radius: 10,
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
                            ).w(80)
                          ],
                        ).px12(),
                        8.height,
                        HtmlEditor(
                          callbacks: Callbacks(
                            onEnter: (){
                              print('entered');
                            },
                            onChangeContent: (val){
                              print('entered');
                            },
                          ),
                          controller: vm.chapterContent, //required
                          htmlEditorOptions: const HtmlEditorOptions(
                            hint: "mulai menulis....",
                            //initalText: "text content initial, if any",
                          ),
                          htmlToolbarOptions: const HtmlToolbarOptions(
                            defaultToolbarButtons: [
                              StyleButtons(),
                              FontButtons(),
                              ListButtons(),
                            ]
                          ),
                          otherOptions: OtherOptions(
                            height: 500,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColor.grey),
                            )
                          ),
                        ).px12(),
                        HStack(
                          [
                            Checkbox(value: vm.locked, onChanged: vm.handleCheckbox),
                            // 8.width,
                            'Berbayar'.text.medium.make(),
                          ]
                        ).px12(),
                        UiSpacer.verticalSpace(),
                      ],
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
                      onPressed: () => vm.addNewChapter('draft', idNovel: viewModel.novelId),
                      title: 'Draft',
                    ).w24(context).centered(),
                    Spacer(),
                    CustomButton(
                      height: 52,
                      isGradientColor: true,
                      loading: vm.busy(vm.chapterName),
                      shapeRadius: 30,
                      onPressed: () => vm.addNewChapter('publish', idNovel: viewModel.novelId),
                      title: 'Publish Sekarang',
                    ).w40(context).centered(),
                  ],
                ).px12(),
                12.height
              ],
            ),
          ),
        );
      }
    );
  }
}
