import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:delta_markdown/delta_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/models/novel_read_chapter.model.dart';
import 'package:read_novel/requests/chapter.request.dart';
import 'package:read_novel/requests/coin.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/views/pages/read_novel/read_novel_chapter.page.dart';
import 'package:read_novel/widgets/bottom_sheets/chapters.bottom_sheet.dart';
import 'package:read_novel/widgets/bottom_sheets/read_settings.bottom_sheet.dart';
import 'package:read_novel/widgets/dialogs/custom_alert.dialog.dart';
import 'package:read_novel/widgets/dialogs/custom_confirm_buy_coin.dialog.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:html2md/html2md.dart' as html2md;


class ReadChapterViewModel extends MyBaseViewModel {
  ReadChapterViewModel(BuildContext context,
      {this.idNovelChapter, this.detailNovel}) {
    viewContext = context;
  }

  int? idNovelChapter;
  CoinRequest coinRequest = CoinRequest();
  ChapterRequest chapterRequest = ChapterRequest();
  Color? selectedColor;
  int selectedFontSize = 15;
  Chapters? selectedChapters;
  List<Chapters>? chapters;
  Read? read;
  DetailNovel? detailNovel;
  QuillController contentText = QuillController.basic();
  List<ScrollController> hideScrollController = [ScrollController()];
  final CarouselController carouselController = CarouselController();
  String? messageFailedToReadTheCh;
  bool failedGetContent = false;
  bool onInsideReadingPage = false;
  bool inHtml = false;
  int? indexChapter;

  @override
  void initialise() {
    getNovelChaptersList();
    getReadNovelChapter();
  }

  //
  Future getNovelChaptersList() async {
    //
    setBusyForObject(chapters, true);

    try {
      chapters = await chapterRequest.getNovelChaptersList(
        idNovel: detailNovel!.id!,
        token: await AuthServices.getAuthBearerToken(),
      );

      chapters?.forEach((element) {
        hideScrollController.add(ScrollController());
      });

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }
    setBusyForObject(chapters, false);
  }

  //
  getReadNovelChapter({int? idChapterPagination, int? index}) async {
    //
    failedGetContent = false;
    onInsideReadingPage = idChapterPagination == null ? false : true;
    setBusyForObject(read, true);

    disableScreenshot();

    try {
      final apiResp = await chapterRequest.getReadNovelChapter(
        {
          'chapter_id': idChapterPagination ?? idNovelChapter,
          'valToken': await AuthServices.getAuthBearerToken(),
        },
      );

      read = apiResp.data;

      // try{
      if((read?.content ?? "<p>").substring(0, 3) == "<p>") {
        inHtml = true;
      }else{
        inHtml = false;
        try{
          contentText = QuillController(
            document: Document.fromJson(jsonDecode(quillHtmlToDelta(read?.content ?? "") ?? "")),
            selection: const TextSelection.collapsed(offset: 0),
          );
        }catch (error){
          inHtml = true;
        }
      }
      // }catch(error){
      //   contentText = QuillController(
      //     document: Document.fromJson(jsonDecode(quillHtmlToDelta(read?.content ?? "", toHtml: true) ?? "")),
      //     selection: const TextSelection.collapsed(offset: 0),
      //   );
      // }

      if (apiResp.status == 'failed') {
        failedGetContent = true;
        messageFailedToReadTheCh = apiResp.message;
        showDialogBuyChapter(read);
      }

      clearErrors();
    } catch (error) {
      print("Error read chapter ==> $error");
      failedGetContent = true;
      setError(error);
    }
    setBusyForObject(read, false);
  }

  //
  String? quillHtmlToDelta(String txt, {bool toHtml = false}) {
    if(toHtml){
      final markdown = html2md.convert(txt);
      final content = markdownToDelta(markdown);

      return content;
    }else {
      return txt;
    }
  }

  //
  startToReadTheChapter(
      {required Chapters chapters,
      required DetailNovel detailNovel,
      required int index}) async {
    selectedChapters = chapters;
    notifyListeners();

    if (chapters.isLocked!) {
      showDialogBuyChapter(chapters);
    } else {
      navToReadChapter(chapters, index);
    }
  }

  handleNavChapters(index) {
    indexChapter = index;
    notifyListeners();
    // scrollController[index].position;
    getReadNovelChapter(
      idChapterPagination: chapters?[index].id,
      index: index,
    );
  }

  //
  navToReadChapter(Chapters chapters, int? index) async {
    viewContext?.navigator
        ?.push(
      MaterialPageRoute(
        builder: (context) => ReadNovelChapterPage(
          idChapters: chapters.id!,
          detailNovel: detailNovel!,
          index: index,
        ),
      ),
    )
        .then((value) async {
      getNovelChaptersList();
    });
  }

  //
  openAvailableChapters() {
    if (detailNovel != null) {
      chaptersBottomSheet(
        context: viewContext!,
        detailNovel: detailNovel!,
      );
    }
  }

  //
  disableScreenshot({bool onClose = false}) async {
    if (!onClose) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } else {
      await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    }
  }

  openReadSetting(ReadChapterViewModel vm) {
    readSettingsBottomSheet(viewContext!, vm);
  }

  handleBgColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  handleFontSize(int size) {
    final varSize = selectedFontSize + size;
    if (varSize >= 14 && varSize <= 18) {
      selectedFontSize = varSize;
    }
    notifyListeners();
  }

  showDialogBuyChapter(chapters) {
    showDialog(
      context: viewContext!,
      barrierDismissible: !busy(coinRequest),
      builder: (context) {
        return customConfirmBuyCoinDialog(
            context: context,
            title: "Beli Bab",
            contentText: "Bab ${chapters.bab} | ${chapters.title} ?",
            onConfirm: () => handleBuyChapter(chapters.id),
            onLoading: busy(coinRequest),
            viewModel: ReadChapterViewModel(viewContext!));
      },
    );
  }

  handleBuyChapter(chapterId, {int? index}) async {
    setBusyForObject(coinRequest, true);

    try {
      final apiResp = await coinRequest.buyChapter(
        chapterId: chapterId,
        token: await AuthServices.getAuthBearerToken(),
      );

      viewContext?.navigator?.pop();

      showDialog(
        context: viewContext!,
        builder: (context) {
          if (apiResp.status == "success") {
            return CustomAlertDialog(
              title: 'Berhasil!',
              contentText: apiResp.message,
            );
          } else {
            return CustomAlertDialog(
              failedResult: true,
              title: apiResp.status ?? 'Gagal!',
              contentText: apiResp.message,
            );
          }
        },
      ).then((value) {
        if (apiResp.status == "success") {
          if(onInsideReadingPage){
            getReadNovelChapter(idChapterPagination: read?.id);
          }else {
            navToReadChapter(selectedChapters!, index);
          }
        }else if(apiResp.message == 'koin anda tidak mencukupi untuk membeli chapter ini'){
          navKoinkuPage();
        }
      });

      clearErrors();
    } catch (error) {
      print("ERROR buy chapter ==> $error");
      setError(error);
    }

    setBusyForObject(coinRequest, false);
  }

  navKoinkuPage() {
    viewContext?.navigator?.pushNamed(AppRoutes.koinkuRoute);
  }

  backPressed() {
    viewContext?.navigator?.pop();
  }
}
