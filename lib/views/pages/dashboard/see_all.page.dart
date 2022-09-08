import 'package:flutter/material.dart';
import 'package:read_novel/view_models/see_all.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:read_novel/widgets/listview_builder/list_novel.builder.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class SeeAllNovelsSectionPage extends StatelessWidget {
  const SeeAllNovelsSectionPage({Key? key, required this.sectionName})
      : super(key: key);
  final String sectionName;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SeeAllViewModel>.reactive(
      viewModelBuilder: () => SeeAllViewModel(context, sectionName),
      onModelReady: (model) => model.initialise(),
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
