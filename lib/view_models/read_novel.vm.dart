import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/models/novel_read_chapter.model.dart';
import 'package:read_novel/requests/novel_detail.request.dart';
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
          'id': idNovel,
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
    viewContext?.navigator?.pushNamed(AppRoutes.readNovelRoute, arguments: chapters);
  }


  openAvailableChapters(ReadNovelViewModel vm) {
    if(detailNovel != null){
      chaptersBottomSheet(viewContext!, detailNovel!, vm);
    }
  }

  backPressed() {
    viewContext?.navigator?.pop();
  }
}