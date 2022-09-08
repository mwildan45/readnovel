import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
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

class ChapterViewModel extends MyBaseViewModel {
  ChapterViewModel(BuildContext context,
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
  ScrollController scrollController = ScrollController();
  final CarouselController carouselController = CarouselController();
  String? messageFailedToReadTheCh;
  bool failedGetContent = false;
  bool onInsideReadingPage = false;
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
      final apiResp = await chapterRequest.getReadNovelChapter({
        'chapter_id': idChapterPagination ?? idNovelChapter,
        'valToken': await AuthServices.getAuthBearerToken(),
      });

      read = apiResp.data;
      print('msg $failedGetContent');
      if (apiResp.status == 'failed') {
        failedGetContent = true;
        messageFailedToReadTheCh = apiResp.message;
        showDialogBuyChapter(read);
      }

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }
    setBusyForObject(read, false);
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

  openReadSetting(ChapterViewModel vm) {
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
            viewModel: ChapterViewModel(viewContext!));
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
        }
      });

      clearErrors();
    } catch (error) {
      print("ERROR buy chapter ==> $error");
      setError(error);
    }

    setBusyForObject(coinRequest, false);
  }

  backPressed() {
    viewContext?.navigator?.pop();
  }
}
