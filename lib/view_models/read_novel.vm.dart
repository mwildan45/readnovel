import 'package:flutter/material.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/requests/novel_detail.request.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/services/dynamic_links_services.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/view_models/chapter.vm.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

class ReadNovelViewModel extends MyBaseViewModel {
  ReadNovelViewModel(BuildContext context, {this.idNovel}) {
    viewContext = context;
  }

  int? idNovel;
  NovelDetailRequest novelDetailRequest = NovelDetailRequest();
  DetailNovel? detailNovel;
  bool isBookmarked = false;
  final DynamicLinkService dynamicLinkService = DynamicLinkService();

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

  onShareNovel() async {
    if(detailNovel != null) {
      final url = await dynamicLinkService.createDynamicLink(detailNovel?.id ?? 0);
      print('created url $url');
      Share.share(url.toString());
    }
  }

  backPressed() {
    viewContext?.navigator?.pop();
  }
}
