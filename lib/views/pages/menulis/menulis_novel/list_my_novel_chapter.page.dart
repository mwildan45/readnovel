import 'package:flutter/material.dart';
import 'package:read_novel/view_models/write_novel.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ListMyNovelChapter extends StatelessWidget {
  const ListMyNovelChapter({Key? key, required this.vm}) : super(key: key);
  final WriteNovelViewModel vm;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      withAppBar: true,
      customAppBar: true,
      activeContext: context,
      title: "Daftar Bab",
      floatingActionWidget: CustomButton(
        height: 52,
        loading: vm.isBusy,
        shapeRadius: 30,
        onPressed: () => vm.addOrUpdateNovel(vm),
        title: 'Tambah Bab',
      ).w32(context),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: VStack(
                List.generate(vm.detailNovel?.chapters?.length ?? 0, (index) {
                  return ListTile(
                    title: (vm.detailNovel?.chapters?[index].title ?? '').text.bold.lg.make(),
                  );
                })
              ),
            ),
          ],
        ),
      ),
    );
  }
}
