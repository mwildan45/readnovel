import 'package:flutter/material.dart';
import 'package:read_novel/view_models/dashboard.vm.dart';
import 'package:read_novel/view_models/see_all.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:read_novel/widgets/listview_builder/list_author.builder.dart';
import 'package:read_novel/widgets/listview_builder/list_novel.builder.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class SeeAllAuthorsSectionPage extends StatelessWidget {
  const SeeAllAuthorsSectionPage({Key? key, this.map})
      : super(key: key);
  final Map? map;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(context),
      onModelReady: (model) => model.fetchAuthors(),
      builder: (context, vm, child) {
        return BasePage(
          activeContext: context,
          withAppBar: true,
          customAppBar: true,
          title: 'Para Authors',
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
                ListAuthorBuilder(
                  vm: vm,
                  noLabel: true,
                  gridview: true,
                ),
              ],
            ).pOnly(left: Vx.dp12, right: Vx.dp12),
          ),
        );
      },
    );
  }
}
