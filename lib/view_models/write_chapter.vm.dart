import 'dart:convert';

import 'package:delta_markdown/delta_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:markdown/markdown.dart' as mk;
import 'package:quill_markdown/quill_markdown.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/chapter.model.dart';
import 'package:read_novel/models/novel_read_chapter.model.dart';
import 'package:read_novel/requests/write.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/widgets/dialogs/custom_alert.dialog.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:html2md/html2md.dart' as html2md;

class WriteChapterViewModel extends MyBaseViewModel {
  WriteChapterViewModel(BuildContext context, {this.idNovel}) {
    viewContext = context;
  }

  int? idNovel;
  WriteRequest writeRequest = WriteRequest();

  List<Chapter>? chapters;
  Read? read;

  TextEditingController chapterName = TextEditingController();
  TextEditingController chapterNumber = TextEditingController();
  late HtmlEditorController chapterContent;
  QuillController content = QuillController.basic();
  bool locked = false;
  int countContent = 0;

  @override
  void initialise() {}

  //
  fetchMyNovelChapters() async {
    setBusyForObject(chapters, true);
    chapters?.clear();

    try {
      chapters = await writeRequest.getMyNovelChapters(idNovel);

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
      // viewContext?.showToast(
      //   msg: "$error",
      //   bgColor: Colors.red,
      // );
    }

    setBusyForObject(chapters, false);
  }

  setInitTextEditingValue(id, {bool onUpdate = false, int? idChapter}) async {
    chapterContent = HtmlEditorController();

    setBusy(true);

    content.document.changes.listen((event) {
      handleCountChar();
    });

    Future.delayed(const Duration(milliseconds: 300), () async {
      await fetchMyNovelChapters();

      if (onUpdate && chapters != null) {
        await getMyNovelChapter(idChapter).then((value) async {
          chapterName = TextEditingController(text: read?.title);
          // chapterContent.setText(read?.content ?? "");
          content = QuillController(
              document: Document.fromJson(jsonDecode(quillHtmlToDelta(read?.content ?? "") ?? "")),
              selection: TextSelection.collapsed(offset: 0));
          handleCountChar();
          locked = read?.coin == 1 ? true : false;
        });
      }

      chapterNumber =
          TextEditingController(text: onUpdate ? read?.bab.toString() : (chapters!.length + 1).toString());

    });

    setBusy(false);
  }

  void dispose() {
    content.removeListener(handleCountChar);
    super.dispose();
  }

  void handleCountChar() {
    final s = content.document.toPlainText();
    final RegExp regExp = RegExp(r"[\w-._]+");
    final Iterable matches = regExp.allMatches(s);
    countContent = matches.length;
    notifyListeners();
  }

  //
  void handleCheckbox(bool? val) {
    locked = !locked;
    notifyListeners();
  }

  Future getMyNovelChapter(idNovelChapter) async {
    //
    setBusyForObject(read, true);

    try {
      read = await writeRequest.getMyNovelChapterDetail({
        'chapter_id': idNovelChapter,
        'valToken': await AuthServices.getAuthBearerToken(),
      });

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }
    setBusyForObject(read, false);

    return true;
  }

  String quillDeltaToHtml(Delta delta) {
    final convertedValue = jsonEncode(delta.toJson());
    final markdown = deltaToMarkdown(convertedValue);
    final html = mk.markdownToHtml(markdown);

    return html;
  }

  String? quillHtmlToDelta(String htmlData) {
    // String? content = '[{"insert":"Heading"},{"insert":"\\n","attributes":{"header":1}},{"insert":"bold","attributes":{"bold":true}},{"insert":"\\n"},{"insert":"bold and italic","attributes":{"bold":true,"italic":true}},{"insert":"\\nsome code"},{"insert":"\\n","attributes":{"code-block":true}},{"insert":"A quote"},{"insert":"\\n","attributes":{"blockquote":true}},{"insert":"ordered list"},{"insert":"\\n","attributes":{"list":"ordered"}},{"insert":"unordered list"},{"insert":"\\n","attributes":{"list":"bullet"}},{"insert":"link","attributes":{"link":"pub.dev/packages/quill_markdown"}},{"insert":"\\n"}]';
    final markdown = html2md.convert(htmlData);
    final content = markdownToDelta(markdown);

    return content;
  }

  //
  addNewAndUpdateChapter(status, {int? idNovel, int? idChapter, bool onUpdate = false}) async {

    if (formKey.currentState!.validate()) {
      var txtContent = quillDeltaToHtml(content.document.toDelta());
      if (txtContent.isNotEmpty) {
        setBusyForObject(status == 'draft' ? chapterNumber : chapterName, true);
        // print('chapter ${txt}, id $idNovel');

        if(countContent <= 1000 && status == 'publish'){
          showToast(msg: 'konten kamu harus mengandung setidaknya 1200 kata!');
        }else {
          try {
            ApiResponse? apiResponse;

            if (onUpdate) {
              apiResponse = await writeRequest.updateChapterNovel(
                chapterId: idChapter!,
                chapterTitle: chapterName.text,
                bab: chapterNumber.text,
                coin: locked ? 1 : 0,
                status: status,
                content: txtContent,
              );
            } else {
              apiResponse = await writeRequest.addChapterNovel(
                novelId: idNovel!,
                chapterTitle: chapterName.text,
                bab: chapterNumber.text,
                coin: locked ? 1 : 0,
                status: status,
                content: txtContent,
              );
            }

            showDialogResponse(apiResponse.message.toString(), (value) {
              viewContext?.navigator?.pop(true);
              // viewContext?.navigator?.pop();
            });

            clearErrors();
          } catch (error) {
            print("Error ==> $error");
            setError(error);
            showToast(msg: "Ops, got error: $error");
          }
        }

        setBusyForObject(status == 'draft' ? chapterNumber : chapterName, false);

      }else{
        showToast(msg: 'konten masih kosong!');
      }
    }
  }

  //
  showDialogResponse(message, Function(dynamic value) action) {
    showDialog(
      context: viewContext!,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: CustomAlertDialog(
            contentText: message,
          ),
        );
      },
    ).then(action);
  }

  //fromNav = create
  navToWriteChapter(bool onUpdate, {int? idChapter}) {
    viewContext?.navigator?.pushNamed(AppRoutes.writeChapterRoute, arguments: {
      'idNovel': idNovel,
      'idChapter': idChapter,
      'onUpdate': onUpdate,
    }).then((value) => fetchMyNovelChapters());
  }
}
