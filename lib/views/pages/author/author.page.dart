import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/author.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/card_image/img_profile.widget.dart';
import 'package:read_novel/widgets/empty_list.widget.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:read_novel/widgets/listview_builder/list_novel.builder.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthorDetailPage extends StatelessWidget {
  const AuthorDetailPage({Key? key, required this.idAuthor}) : super(key: key);
  final int idAuthor;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthorViewModel>.reactive(
      viewModelBuilder: () => AuthorViewModel(context, idAuthor),
      onModelReady: (model) => model.getAuthorDetail(),
      builder: (context, vm, child) {
        return BasePage(
          activeContext: context,
          withAppBar: true,
          customAppBar: true,
          title: 'Author Detail',
          isLoading: vm.isBusy,
          body: VStack(
            [
              UiSpacer.verticalSpace(),
              ImageProfileWidget(
                urlProfilePic: vm.author?.profile,
                radius: 50,
              ).centered(),
              8.height,
              (vm.author?.namaPena ?? 'author').text.lg.bold.make().centered(),
              UiSpacer.verticalSpace(),
              "Karya Novel".text.bold.lg.make().px16(),
              4.height,
              UiSpacer.divider(
                      color: AppColor.romanSilver, width: Vx.dp64, thickness: 2)
                  .px16(),
              // UiSpacer.verticalSpace(),
              Stack(
                children: [
                  SingleChildScrollView(
                    child: ListNovelBuilder(
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
                    ).px12(),
                  ),
                  Positioned.fill(
                    bottom: 0.0,
                    right: 0.0,
                    left: 0.0,
                    child: vm.novels != null && vm.novels!.isEmpty
                        ? const EmptyListWidget(textEmpty: 'author belum merilis apapun.',).objectCenter()
                        : const SizedBox.shrink(),
                  )
                ],
              ).wFull(context).expand(),
            ],
          ),
        );
      },
    );
  }
}
