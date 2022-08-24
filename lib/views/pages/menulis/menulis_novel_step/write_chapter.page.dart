import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:read_novel/view_models/menulis.vm.dart';
import 'package:velocity_x/velocity_x.dart';

class WriteChapterPage extends StatelessWidget {
  const WriteChapterPage({Key? key, required this.vm}) : super(key: key);
  final MenulisViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        HtmlEditor(
          controller: vm.chapterContent, //required
          htmlEditorOptions: HtmlEditorOptions(
            hint: "Your text here...",
            //initalText: "text content initial, if any",
          ),
          otherOptions: OtherOptions(
            height: 400,
          ),
        ).expand()
      ]
    );
  }
}
