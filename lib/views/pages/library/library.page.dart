import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/library.vm.dart';
import 'package:read_novel/widgets/custom_tabbar.widget.dart';
import 'package:read_novel/widgets/listview_builder/list_histories.builder.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> /*with AutomaticKeepAliveClientMixin<LibraryPage> */ {
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return ViewModelBuilder<LibraryViewModel>.reactive(
        viewModelBuilder: () => LibraryViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, vm, child) {
          return SafeArea(
            child: VStack([
              8.height,
              // Image.asset(AppImages.appLogoOnly).w(30).objectCenterRight().px4(),
              2.height,
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: VStack([
                    Row(
                      children: [
                        CustomTabBarWidget(
                          labelText: AppStrings.listTabLabelLibrary,
                        ).expand(),
                        Image.asset(AppImages.appLogoOnly)
                            .w(30)
                            .objectCenterRight()
                            .px4(),
                      ],
                    ),
                    UiSpacer.verticalSpace(space: Vx.dp12),
                    TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ListHistories(vm: vm,),
                        ListHistories(
                          onLoading: vm.busy(vm.bookmark),
                          novel: vm.bookmark,
                          vm: vm,
                        ),
                      ],
                    ).expand(),
                  ]),
                ),
              ),
              // 'Terakhir Dibaca'.text.medium.make().px4(),
              // UiSpacer.divider(width: 78).px4(),
              // 8.height,
              // const ListReadHistories().px4().expand()
            ]).px8(),
          );
        });
  }

  // @override
  // bool get wantKeepAlive => true;
}
