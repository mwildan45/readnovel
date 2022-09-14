import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/dashboard.vm.dart';
import 'package:read_novel/widgets/card_image/img_profile.widget.dart';
import 'package:skeletons/skeletons.dart';
import 'package:velocity_x/velocity_x.dart';

class ListAuthorBuilder extends StatelessWidget {
  const ListAuthorBuilder(
      {Key? key,
      this.label,
      required this.vm,
      this.gridview = false,
      this.noLabel = false, this.onTapSeeAllAuthors})
      : super(key: key);
  final String? label;
  final DashboardViewModel vm;
  final bool gridview;
  final bool noLabel;
  final Function()? onTapSeeAllAuthors;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        noLabel
            ? const SizedBox.shrink()
            : VStack([
                UiSpacer.verticalSpace(space: Vx.dp20),
                HStack(
                  [
                    (label ?? 'label').text.lg.bold.make().expand(),
                    "Lihat Semua".text.size(12).make().onTap(onTapSeeAllAuthors)
                  ],
                ),
              ]),
        UiSpacer.verticalSpace(space: Vx.dp8),
        _buildList(),
      ],
    );
  }

  _buildList() {
    if (!gridview) {
      return SizedBox(
        height: 80,
        child: vm.busy(vm.authors)
            ? ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        shape: BoxShape.circle, width: 50, height: 50),
                  ).pOnly(right: Vx.dp10);
                },
              )
            : ListView.builder(
                itemCount: vm.authors?.length ?? 0,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return VStack(
                    [
                      ImageProfileWidget(
                        urlProfilePic: vm.authors?[index].profile,
                        radius: 30,
                      ),
                      2.height,
                      (vm.authors?[index].namaPena ?? "-")
                          .text
                          .sm
                          .ellipsis
                          .maxLines(1)
                          .make()
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                  ).w(60).onTap(() => vm.openDetailAuthors(vm.authors?[index].id)).pOnly(right: Vx.dp10);
                },
              ),
      );
    } else {
      return DynamicHeightGridView(
        itemCount: vm.authors?.length ?? 0,
        crossAxisCount: 3,
        crossAxisSpacing: Vx.dp16,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: Vx.dp16,
        builder: (context, index) {
          return VStack(
            [
              ImageProfileWidget(
                urlProfilePic: vm.authors?[index].profile,
                radius: 50,
              ),
              2.height,
              (vm.authors?[index].namaPena ?? "-")
                  .text
                  .sm
                  .ellipsis
                  .maxLines(1)
                  .make()
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).w(80).onTap(() => vm.openDetailAuthors(vm.authors?[index].id)).pOnly(right: Vx.dp10);
        },
      );
    }
  }
}
