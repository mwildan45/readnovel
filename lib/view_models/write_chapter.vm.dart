import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/chapter.model.dart';
import 'package:read_novel/models/novel_read_chapter.model.dart';
import 'package:read_novel/requests/novel_detail.request.dart';
import 'package:read_novel/requests/write.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/widgets/dialogs/custom_alert.dialog.dart';
import 'package:velocity_x/velocity_x.dart';

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
  bool locked = false;

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

    Future.delayed(const Duration(milliseconds: 300), () async {
      await fetchMyNovelChapters();

      if (onUpdate && chapters != null) {
        await getMyNovelChapter(idChapter).then((value) async {
          chapterName = TextEditingController(text: read?.title);
          chapterContent.setText(read?.content ?? "");
          locked = read?.coin == 1 ? true : false;
        });
      }

      chapterNumber =
          TextEditingController(text: onUpdate ? read?.bab.toString() : (chapters!.length + 1).toString());

    });

    setBusy(false);
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

  //
  addNewAndUpdateChapter(status, {int? idNovel, int? idChapter, bool onUpdate = false}) async {

    if (formKey.currentState!.validate()) {
      var txtContent = await chapterContent.getText();
      if (txtContent.isNotEmpty) {
        setBusyForObject(status == 'draft' ? chapterNumber : chapterName, true);
        // print('chapter ${txt}, id $idNovel');

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

        setBusyForObject(
            status == 'draft' ? chapterNumber : chapterName, false);
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
