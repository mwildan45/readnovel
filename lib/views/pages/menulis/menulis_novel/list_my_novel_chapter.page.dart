import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/view_models/write_chapter.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:read_novel/widgets/list_items/my_chapters.item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class ListMyNovelChapter extends StatelessWidget {
  const ListMyNovelChapter({Key? key, required this.idNovel}) : super(key: key);
  final int idNovel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WriteChapterViewModel>.reactive(
        viewModelBuilder: () => WriteChapterViewModel(context, idNovel: idNovel),
        onModelReady: (model) => model.fetchMyNovelChapters(),
        builder: (context, vm, child) {
          return BasePage(
            withAppBar: true,
            customAppBar: true,
            activeContext: context,
            isLoading: vm.busy(vm.chapters),
            title: "Daftar Bab",
            floatingActionWidget: CustomButton(
              height: 52,
              shapeRadius: 30,
              onPressed: () => vm.navToWriteChapter(false),
              title: 'Tambah Bab',
            ).w32(context),
            body: SafeArea(
              child: Column(
                children: [
                  8.height,
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: vm.chapters?.length ?? 0,
                    itemBuilder: (context, index) {
                      return MyChaptersItem(
                        vm: vm,
                        index: index,
                      ).onTap(() => vm.navToWriteChapter(true, idChapter: vm.chapters?[index].id));
                    },
                    separatorBuilder: (context, index) => 5.height,
                  ).expand()
                ],
              ),
            ),
          );
        });
  }
}
