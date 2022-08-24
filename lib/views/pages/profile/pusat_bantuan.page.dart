import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/profile.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class PusatBantuanPage extends StatelessWidget {
  const PusatBantuanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(context),
      onModelReady: (model) => model.getFAQData(),
      builder: (context, vm, child) {
        return BasePage(
          withAppBar: true,
          activeContext: context,
          isLoading: vm.busy(vm.faq),
          body: SingleChildScrollView(
            child: VStack(
              [
                UiSpacer.verticalSpace(),
                'Pusat Bantuan'.text.xl2.bold.make().px16(),
                12.height,
                ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  separatorBuilder: (context, index) => Divider(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: vm.faq?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ExpandablePanel(
                      header: Text('${vm.faq?[index].title}'),
                      collapsed: SizedBox.shrink(),
                      expanded: Text(
                        '${vm.faq?[index].content}',
                        softWrap: true,
                        style: TextStyle(color: AppColor.fontColor),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
