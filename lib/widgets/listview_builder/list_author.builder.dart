import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class ListAuthorBuilder extends StatelessWidget {
  const ListAuthorBuilder({Key? key, required this.label}) : super(key: key);
  final String? label;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        UiSpacer.verticalSpace(space: Vx.dp16),
        HStack(
          [
            (label ?? 'label').text.lg.bold.make().expand(),
            "Lihat Semua".text.size(12).make()
          ],
        ),
        UiSpacer.verticalSpace(space: Vx.dp8),
        SizedBox(
          height: 80,
          child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return VStack(
                [
                  const CircleAvatar(radius: 30),
                  2.height,
                  "Author ${index + 1}".text.sm.ellipsis.maxLines(1).make()
                ],
                crossAlignment: CrossAxisAlignment.center,
              ).w(60).pOnly(right: Vx.dp10);
            },
          ),
        ),
      ],
    );
  }
}
