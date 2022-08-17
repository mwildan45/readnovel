import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_images.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/widgets/listview_builder/list_novel.builder.dart';
import 'package:read_novel/widgets/listview_builder/list_read_histories.builder.dart';
import 'package:velocity_x/velocity_x.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: VStack(
        [
          8.height,
          HStack(
            [
              'Library'.text.lg.bold.letterSpacing(0.9).make().expand(),
              Image.asset(AppImages.appLogoOnly).w(30),
            ],
          ),
          2.height,
          'Terakhir Dibaca'.text.medium.make(),
          UiSpacer.divider(width: 78).px4(),
          8.height,
          const ListReadHistories().px4().expand()
        ]
      ).px8(),
    );
  }
}
