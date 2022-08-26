import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/models/novel_read_chapter.model.dart';
import 'package:read_novel/requests/novel_detail.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/views/pages/read_novel/read_novel_chapter.page.dart';
import 'package:read_novel/widgets/bottom_sheets/chapters.bottom_sheet.dart';
import 'package:read_novel/widgets/bottom_sheets/read_settings.bottom_sheet.dart';
import 'package:velocity_x/velocity_x.dart';

class ReadNovelViewModel extends MyBaseViewModel {
  ReadNovelViewModel(BuildContext context, {this.idNovel, this.idNovelChapter}){
    viewContext = context;
  }

  int? idNovel;
  int? idNovelChapter;
  NovelDetailRequest novelDetailRequest = NovelDetailRequest();
  DetailNovel? detailNovel;
  Read? read;
  ScrollController scrollController = ScrollController();
  bool isBookmarked = false;
  Color? selectedColor;
  int selectedFontSize = 15;

  @override
  void initialise(){

  }

  getNovelDetail() async {

    // final token = await AuthServices.getAuthBearerToken();
    // print('id $token');
    //
    setBusyForObject(detailNovel, true);

    try {
      detailNovel = await novelDetailRequest.getNovelDetail(
        {
          'novel_id': idNovel,
          'valToken': await AuthServices.getAuthBearerToken(),
        }
      );

      isBookmarked = detailNovel!.isBookmarked!;
      notifyListeners();

      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusyForObject(detailNovel, false);
  }


  getReadNovelChapter() async {
    //
    setBusyForObject(read, true);

    disableScreenshot();

    try {
      read = await novelDetailRequest.getReadNovelChapter(
        {
          'chapter_id': idNovelChapter,
          'valToken': await AuthServices.getAuthBearerToken(),
        }
      );

      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusyForObject(read, false);
  }


  handleBookmark() async {
    //
    if(detailNovel != null) {

      setBusyForObject(isBookmarked, true);

      try {
        var resp = await novelDetailRequest.handleBookmark(
            {
              'novel_id': idNovel,
              'valToken': await AuthServices.getAuthBearerToken(),
            }
        );

        if (resp == 'Novel dibookmark' || resp == "Novel ditambah dibookmark") {
          isBookmarked = true;
        } else if (resp == 'Novel dihapus dari bookmark') {
          isBookmarked = false;
        }
        notifyListeners();

        clearErrors();
      } catch (error) {
        setError(error);
      }
      setBusyForObject(isBookmarked, false);
    }
  }


  startToReadTheChapter(Chapters chapters, DetailNovel detailNovel) async {
    if (chapters.isLocked!) {

    }else{
      viewContext?.navigator?.push(
          MaterialPageRoute(builder: (context) => ReadNovelChapterPage(chapters: chapters, detailNovel: detailNovel,)));
    }
  }


  openAvailableChapters(ReadNovelViewModel vm) {
    if(detailNovel != null){
      chaptersBottomSheet(viewContext!, detailNovel!, vm);
    }
  }


  backPressed() {
    viewContext?.navigator?.pop();
  }


  disableScreenshot({bool onClose = false}) async {
    if(!onClose){
      await FlutterWindowManager.addFlags(
          FlutterWindowManager.FLAG_SECURE);
    }else{
      await FlutterWindowManager.clearFlags(
          FlutterWindowManager.FLAG_SECURE);
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
    if(_size >= 14 && _size <= 18) {
      selectedFontSize = _size;
    }
    notifyListeners();
  }
}