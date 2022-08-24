import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/profile.vm.dart';
import 'package:read_novel/widgets/img_profile.widget.dart';
import 'package:read_novel/widgets/list_items/profile_list_menu.item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, vm, child) {
        return SafeArea(
          child: Container(
            color: AppColor.ghostWhite2,
            child: VStack(
              [
                8.height,
                VStack(
                  [
                    const ImageProfileWidget(),
                    UiSpacer.verticalSpace(space: Vx.dp4),
                    ("${getStringAsync(AppStrings.firstName)} ${getStringAsync(AppStrings.lastName)}").text.bold.lg.xl2.make().center(),
                    getStringAsync(AppStrings.userEmail).text.medium.size(12).make().center(),
                  ],
                  crossAlignment: CrossAxisAlignment.stretch,
                ).p12(),
                16.height,
                Expanded(
                  child: VStack(
                    [
                      12.height,
                      ProfileListItemMenu(
                        icon: FontAwesomeIcons.coins,
                        label: 'Koinku',
                        onTap: vm.navKoinkuPage,
                      ),
                      UiSpacer.verticalSpace(space: Vx.dp12),
                      const ProfileListItemMenu(
                        icon: FontAwesomeIcons.book,
                        label: 'Buku Saya',
                      ),
                      UiSpacer.divider(width: double.maxFinite).py16(),
                      const ProfileListItemMenu(
                        icon: FontAwesomeIcons.feed,
                        label: 'Umpan Balik',
                      ),
                      UiSpacer.divider(width: double.maxFinite).py16(),
                      const ProfileListItemMenu(
                        icon: FontAwesomeIcons.share,
                        label: 'Bagikan ReadNovel',
                      ),
                      UiSpacer.verticalSpace(space: Vx.dp12),
                      const ProfileListItemMenu(
                        icon: FontAwesomeIcons.instagramSquare,
                        label: 'Instagram',
                      ),
                      UiSpacer.verticalSpace(space: Vx.dp12),
                      ProfileListItemMenu(
                        icon: FontAwesomeIcons.solidCircleQuestion,
                        label: 'Pusat Bantuan',
                        onTap: vm.navPusatBantuanPage,
                      ),
                      UiSpacer.verticalSpace(space: Vx.dp12),
                      ProfileListItemMenu(
                        icon: FontAwesomeIcons.circleArrowLeft,
                        label: 'Logout',
                        onTap: vm.processLogout,
                      ),
                      // 8.height
                    ],
                  ).p12().scrollVertical().box.white.topRounded(value: 18).make().px(10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
