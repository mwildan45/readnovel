import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/view_models/see_all.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/form_field/general.form_field.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:read_novel/widgets/listview_builder/list_novel.builder.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class SeeAllNovelsSectionPage extends StatelessWidget {
  const SeeAllNovelsSectionPage({Key? key, required this.map})
      : super(key: key);
  final Map map;

  @override
  Widget build(BuildContext context) {
    String sectionName = map['sectionName'];
    String? keyword = map['keyword'];
    return ViewModelBuilder<SeeAllViewModel>.reactive(
      viewModelBuilder: () => SeeAllViewModel(context, sectionName),
      onModelReady: (model) => model.initialise(keyword: keyword),
      builder: (context, vm, child) {
        return BasePage(
          activeContext: context,
          withAppBar: true,
          customAppBar: true,
          onBackPressed: vm.onBackPressed,
          title: vm.pageTitle,
          body: SingleChildScrollView(
            child: VStack(
              [
                // CustomTextFormField(
                //   height: 38,
                //   hintText: 'Mantan Tapi Menikah',
                //   prefixIcon: Icon(
                //     FontAwesomeIcons.magnifyingGlass,
                //     size: 16,
                //   ),
                //   maxLines: 1,
                //   onTap: () => print('p'),
                // ),
                ListNovelBuilder(
                  noLabel: true,
                  isVerticalList: true,
                  onLoading: vm.isBusy,
                  itemCount: vm.novels?.length,
                  itemBuilder: (context, index) {
                    return NovelItem(
                      isInfoOnRightPosition: true,
                      index: index,
                      novel: vm.novels?[index],
                      onItemTap: () => vm.openNovel(vm.novels?[index].id, vm.novels?[index]),
                    );
                  },
                ),
              ],
            ).pOnly(left: Vx.dp12, right: Vx.dp12),
          ),
        );
      },
    );
  }
}
