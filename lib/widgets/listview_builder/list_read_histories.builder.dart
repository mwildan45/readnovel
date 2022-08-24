import 'package:flutter/material.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:read_novel/widgets/list_items/history_novel.item.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:velocity_x/velocity_x.dart';

class ListReadHistories extends StatelessWidget {
  const ListReadHistories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        ListView.builder(
          shrinkWrap: true,
          // scrollDirection: Axis.horizontal,
          itemCount: imgList.length,
          itemBuilder: (context, index) {
            return NovelItem(
              index: index,
              isInfoOnRightPosition: true,
            ).p2();
          },
        ).expand()
      ]
    );
  }
}
