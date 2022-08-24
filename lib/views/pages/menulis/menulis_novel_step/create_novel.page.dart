import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/models/ages.model.dart';
import 'package:read_novel/models/genres.model.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/menulis.vm.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/form_field/general.form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateNovelPage extends StatelessWidget {
  const CreateNovelPage({Key? key, required this.vm}) : super(key: key);
  final MenulisViewModel vm;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: VStack(
        [
          8.height,
          'Buat Novel Baru'.text.bold.xl2.make(),
          UiSpacer.verticalSpace(),
          const Icon(FontAwesomeIcons.image)
              .box
              .border(color: AppColor.fadedGrey)
              .rounded
              .width(130)
              .height(180)
              .make()
              .centered(),
          8.height,
          CustomButton(
            onPressed: () {},
            height: 30,
            title: 'upload cover',
            color: AppColor.royalOrange,
            shapeRadius: 15,
          ).w(120),
          UiSpacer.verticalSpace(),
          Form(
            child: VStack(
              [
                CustomTextFormField(
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
                          ...buildAges(vm.ages),
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
                          ...buildGenres(vm.genres),
                        ],
                      ).p8(),
              ],
            ),
          ).px12()
        ],
        crossAlignment: CrossAxisAlignment.center,
      ),
    );
  }


  buildAges(List<Ages>? ages) {
    return ages?.map((e) {
      return '${e.name}'
          .text
          .lg.color(vm.agesMap[e.id] == true ? AppColor.lotion : AppColor.fontColor)
          .make().center()
          .box
          .withRounded(value: 8)
          .color(vm.agesMap[e.id] == true ? AppColor.cerisePink : AppColor.fadedGrey)
          .make()
          .w(80).h(30).onTap(() => vm.handleSelectAge(e.id, vm.agesMap[e.id] == true ? false : true));
    }).toList();
  }


  buildGenres(List<Genres>? genres) {
    return genres?.map((e) {
      return '${e.name}'
          .text
          .lg.color(vm.genresMap[e.id] == true ? AppColor.lotion : AppColor.fontColor)
          .make()
          .px8().pOnly(top: 2)
          .box
          .withRounded(value: 8)
          .color(vm.genresMap[e.id] == true ? AppColor.cyan : AppColor.fadedGrey)
          .make()
          .h(30).onTap(() => vm.handleSelectGenre(e.id, vm.genresMap[e.id] == true ? false : true));
    }).toList();
  }

}
