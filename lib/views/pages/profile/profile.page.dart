import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/profile.vm.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
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
          child: VStack(
            [
              VStack(
                [
                  HStack(
                    [
                      CircleAvatar(
                        radius: Vx.dp32,
                        child: Image.network(getStringAsync(AppStrings.profileImg)),
                      ),
                      UiSpacer.horizontalSpace(space: Vx.dp8),
                      VStack([
                        'admin'.text.bold.lg.make(),
                        'admin@gmail.com'.text.medium.size(12).make(),
                      ]).expand()
                    ],
                  ),
                  UiSpacer.verticalSpace(space: Vx.dp12),
                  'Akun Saya'.text.sm.fontWeight(FontWeight.w500).make(),
                  UiSpacer.verticalSpace(space: Vx.dp2),
                  HStack(
                    [
                      '10'.text.bold.lg.xl3.make(),
                      'Koin'.text.sm.make().pOnly(bottom: Vx.dp4, left: Vx.dp3),
                    ],
                    crossAlignment: CrossAxisAlignment.end,
                  ),
                  UiSpacer.verticalSpace(space: Vx.dp5),
                  CustomButton(
                    title: 'Top Up',
                    onPressed: () {},
                    isFixedHeight: true,
                    shapeRadius: 15,
                  ),
                  UiSpacer.verticalSpace(space: Vx.dp5),
                ],
              ).p12().box.white.make(),
              UiSpacer.verticalSpace(space: Vx.dp8),
              VStack(
                [
                  const ProfileListItemMenu(
                    icon: FontAwesomeIcons.coins,
                    label: 'Koinku',
                  ),
                  UiSpacer.verticalSpace(space: Vx.dp12),
                  const ProfileListItemMenu(
                    icon: FontAwesomeIcons.book,
                    label: 'Buku Saya',
                  ),
                ],
              ).p12().box.white.make(),
              UiSpacer.verticalSpace(space: Vx.dp8),
              const VStack(
                [
                  ProfileListItemMenu(
                    icon: FontAwesomeIcons.comments,
                    label: 'Umpan Balik',
                  ),
                ],
              ).p12().box.white.make(),
              UiSpacer.verticalSpace(space: Vx.dp8),
              VStack(
                [
                  const ProfileListItemMenu(
                    icon: FontAwesomeIcons.share,
                    label: 'Bagikan ReadNovel',
                  ),
                  UiSpacer.verticalSpace(space: Vx.dp12),
                  const ProfileListItemMenu(
                    icon: FontAwesomeIcons.instagram,
                    label: 'Instagram',
                  ),
                  UiSpacer.verticalSpace(space: Vx.dp12),
                  const ProfileListItemMenu(
                    icon: FontAwesomeIcons.circleQuestion,
                    label: 'Pusat Bantuan',
                  ),
                  UiSpacer.verticalSpace(space: Vx.dp12),
                  ProfileListItemMenu(
                    icon: FontAwesomeIcons.arrowRightToBracket,
                    label: 'Login',
                    onTap: vm.onLoginPage,
                  ),
                ],
              ).p12().box.white.make(),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
