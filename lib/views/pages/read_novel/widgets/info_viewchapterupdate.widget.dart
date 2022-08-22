import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class InfoViewChapterUpdateWIdget extends StatelessWidget {
  const InfoViewChapterUpdateWIdget({Key? key, this.data}) : super(key: key);
  final DetailNovel? data;

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        richText(
          text: '100rb dilihat',
          selected: '100rb',
        ),
        UiSpacer.greyedVerticalDivider().px8(),
        richText(
          text: '${data?.chapter ?? "0"} Bab',
          selected: '23',
        ),
        UiSpacer.greyedVerticalDivider().px8(),
        richText(
          text: 'status: ${data?.status ?? ""}',
          selected: 'Harian',
        ),
      ],
    ).box.p12.rounded.linearGradient(
      [AppColor.ghostWhite, AppColor.azureishWhite],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ).make();
  }

  Widget richText({required String text, required String selected}) {
    return EasyRichText(
      text,
      patternList: [
        EasyRichTextPattern(
          targetString: selected,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
      defaultStyle:
      TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.7)),
      textAlign: TextAlign.center,
    );
  }

}
