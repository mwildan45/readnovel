import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/dashboard.vm.dart';
import 'package:read_novel/views/pages/dashboard/widgets/genres_tab.widget.dart';
import 'package:read_novel/views/pages/dashboard/widgets/home_tab.widget.dart';
import 'package:read_novel/widgets/form_field/general.form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, vm, child) {
        return SafeArea(
          child: VStack(
            [
              VStack(
                [
                  Image.asset(AppImages.appLogoHorizontal).w(130),
                  UiSpacer.verticalSpace(space: Vx.dp12),
                  CustomTextFormField(
                    height: 38,
                    hintText: 'Mantan Tapi Menikah',
                    prefixIcon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 16,
                    ),
                    maxLines: 1,
                  ),
                  UiSpacer.verticalSpace(space: Vx.dp8),
                ],
              ).pOnly(left: Vx.dp12, right: Vx.dp12, top: Vx.dp12),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: VStack([
                    TabBar(
                      indicatorColor: AppColor.royalOrange,
                      labelStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColor.black),
                      indicatorWeight: 1.5,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: const [
                        Tab(
                          text: 'Home',
                        ),
                        Tab(
                          text: 'Genres',
                        ),
                      ],
                    ).w(150).h(30),
                    UiSpacer.verticalSpace(space: Vx.dp4),
                    TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        HomeTabWidget(vm: vm),
                        GenresTabWidget()
                      ],
                    ).expand(),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
