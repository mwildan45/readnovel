import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/models/novel_read_chapter.model.dart';
import 'package:read_novel/requests/novel_detail.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/widgets/bottom_sheets/chapters_bottom_sheet.dart';
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

  @override
  void initialise(){
    print('id $idNovel');
  }

  getNovelDetail() async {
    //
    setBusyForObject(detailNovel, true);

    try {
      detailNovel = await novelDetailRequest.getNovelDetail(
        {
          'novel_id': idNovel,
          'valToken': await AuthServices.getAuthBearerToken(),
        }
      );

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
          'user_id': 1,
        }
      );

      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusyForObject(read, false);
  }


  startToReadTheChapter(Chapters chapters) async {
    if (chapters.isLocked!) {

    }else{
      viewContext?.navigator?.pushNamed(
          AppRoutes.readNovelRoute, arguments: chapters);
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
}