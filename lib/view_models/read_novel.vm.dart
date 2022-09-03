import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/models/novel_read_chapter.model.dart';
import 'package:read_novel/requests/coin.request.dart';
import 'package:read_novel/requests/novel_detail.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/views/pages/read_novel/read_novel_chapter.page.dart';
import 'package:read_novel/widgets/bottom_sheets/chapters.bottom_sheet.dart';
import 'package:read_novel/widgets/bottom_sheets/read_settings.bottom_sheet.dart';
import 'package:read_novel/widgets/dialogs/custom_alert.dialog.dart';
import 'package:read_novel/widgets/dialogs/custom_confirm_buy_coin.dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class ReadNovelViewModel extends MyBaseViewModel {
  ReadNovelViewModel(BuildContext context,
      {this.idNovel, this.idNovelChapter}) {
    viewContext = context;
  }

  int? idNovel;
  int? idNovelChapter;
  NovelDetailRequest novelDetailRequest = NovelDetailRequest();
  CoinRequest coinRequest = CoinRequest();
  DetailNovel? detailNovel;
  Read? read;
  ScrollController scrollController = ScrollController();
  bool isBookmarked = false;
  Color? selectedColor;
  int selectedFontSize = 15;
  Chapters? selectedChapters;

  @override
  void initialise() {}

  Future getNovelDetail() async {
    setBusyForObject(detailNovel, true);

    try {
      detailNovel = await novelDetailRequest.getNovelDetail({
        'novel_id': idNovel,
        'valToken': await AuthServices.getAuthBearerToken(),
      });

      isBookmarked = detailNovel!.isBookmarked!;
      notifyListeners();

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }
    setBusyForObject(detailNovel, false);
  }

  getReadNovelChapter() async {
    //
    setBusyForObject(read, true);

    disableScreenshot();
    read = await novelDetailRequest.getReadNovelChapter({
      'chapter_id': idNovelChapter,
      'valToken': await AuthServices.getAuthBearerToken(),
    });
    try {
      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }
    setBusyForObject(read, false);
  }

  handleBookmark() async {
    //
    if (detailNovel != null) {
      setBusyForObject(isBookmarked, true);

      try {
        var resp = await novelDetailRequest.handleBookmark({
          'novel_id': idNovel,
          'valToken': await AuthServices.getAuthBearerToken(),
        });

        if (resp == 'Novel dibookmark' || resp == "Novel ditambah dibookmark") {
          isBookmarked = true;
        } else if (resp == 'Novel dihapus dari bookmark') {
          isBookmarked = false;
        }
        notifyListeners();

        clearErrors();
      } catch (error) {
        print("ERROR Bookmark ==> $error");
        setError(error);
      }
      setBusyForObject(isBookmarked, false);
    }
  }

  startToReadTheChapter(Chapters chapters, DetailNovel detailNovel) async {
    selectedChapters = chapters;
    notifyListeners();

    if (chapters.isLocked!) {
      showDialogBuyChapter(chapters);
    } else {
      navToReadChapter(chapters, detailNovel);
    }
  }

  navToReadChapter(Chapters chapters, DetailNovel detailNovel) async {
    viewContext?.navigator?.pop();
    viewContext?.navigator
        ?.push(
      MaterialPageRoute(
        builder: (context) => ReadNovelChapterPage(
          idChapters: chapters.id!,
          detailNovel: detailNovel,
        ),
      ),
    ).then((value) async {
      // await getNovelDetail().then((value) {
      //   openAvailableChapters(ReadNovelViewModel(viewContext!, idNovel: idNovel));
      // });
    });
  }

  openAvailableChapters(ReadNovelViewModel vm) {
    if (detailNovel != null) {
      chaptersBottomSheet(viewContext!, detailNovel!, vm);
    }
  }

  backPressed() {
    viewContext?.navigator?.pop();
  }

  disableScreenshot({bool onClose = false}) async {
    if (!onClose) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } else {
      await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    }
  }

  openReadSetting(ReadNovelViewModel vm) {
    readSettingsBottomSheet(viewContext!, vm);
  }

  handleBgColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  handleFontSize(int size) {
    final _size = selectedFontSize + size;
    if (_size >= 14 && _size <= 18) {
      selectedFontSize = _size;
    }
    notifyListeners();
  }

  showDialogBuyChapter(Chapters chapters) {
    showDialog(
      context: viewContext!,
      builder: (context) {
        return CustomConfirmBuyCoinDialog(
          title: "Beli Bab",
          contentText: "Bab ${chapters.bab} | ${chapters.title} ?",
          onConfirm: () => handleBuyChapter(chapters.id),
          onLoading: busy(coinRequest),
        );
      },
    );
  }

  handleBuyChapter(chapterId) async {
    // setBusyForObject(coinRequest, true);
    viewContext?.navigator?.pop();

    try {
      final apiResp = await coinRequest.buyChapter(
        chapterId: chapterId,
        token: await AuthServices.getAuthBearerToken(),
      );

      showDialog(
        context: viewContext!,
        builder: (context) {
          if(apiResp.status == "success") {
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
        if(apiResp.status == "success") {
          navToReadChapter(selectedChapters!, detailNovel!);
        }
      });

      clearErrors();
    } catch (error) {
      print("ERROR buy chapter ==> $error");
      setError(error);
    }

  }
}
