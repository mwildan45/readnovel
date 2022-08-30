import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/ages.model.dart';
import 'package:read_novel/models/genres.model.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/requests/ages.request.dart';
import 'package:read_novel/requests/genres.request.dart';
import 'package:read_novel/requests/novel_detail.request.dart';
import 'package:read_novel/requests/write.request.dart';
import 'package:read_novel/services/app.services.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/widgets/dialogs/custom_alert.dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class WriteNovelViewModel extends MyBaseViewModel {
  WriteNovelViewModel(BuildContext context) {
    viewContext = context;
  }

  int currentIndex = 0;
  PageController pageViewController = PageController(initialPage: 0);
  StreamSubscription? menulisPageChangeStream;

  GenresRequest genresRequest = GenresRequest();
  AgesRequest agesRequest = AgesRequest();
  WriteRequest writeRequest = WriteRequest();
  DetailNovel? detailNovel;
  List<Genres>? genres;
  List<Ages>? ages;
  var agesMap = <int, bool>{};
  var genresMap = <int, bool>{};
  int? novelId;

  TextEditingController novelName = TextEditingController();
  TextEditingController synopsis = TextEditingController();

  TextEditingController chapterName = TextEditingController();
  TextEditingController chapterNumber = TextEditingController();
  HtmlEditorController chapterContent = HtmlEditorController();
  bool locked = false;

  XFile? selectedNovelCover;

  @override
  void initialise() {
    // menulisPageChangeStream = AppService.instance?.homePageIndex.stream.listen(
    //   (index) {
    //     onTabChange(index);
    //   },
    // );

    fetchAges();
    fetchGenres();
  }

  //
  @override
  dispose() {
    super.dispose();
    menulisPageChangeStream?.cancel();
  }

  //
  onImageSelected(XFile file) {
    selectedNovelCover = file;
    notifyListeners();
  }

  //
  onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  //
  onTabChange(int index) {
    print("index $index");
    if (index >= 0) {
      currentIndex = index;
      pageViewController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
      notifyListeners();
    } else {
      viewContext?.navigator?.pop();
    }
  }

  getNovelDetail(idNovel) async {
    setBusyForObject(detailNovel, true);

    fetchAges();
    fetchGenres();

    try {
      detailNovel = await writeRequest.getMyNovelDetail({
        'novel_id': idNovel,
        'valToken': await AuthServices.getAuthBearerToken(),
      });

      novelName = TextEditingController(text: detailNovel?.title);
      synopsis = TextEditingController(text: detailNovel?.synopsis);
      agesMap.putIfAbsent(detailNovel!.age!.toInt(), () => true);
      detailNovel?.genre?.forEach((element) {
        genresMap.putIfAbsent(element.toInt(), () => true);
      });
      notifyListeners();

      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusyForObject(detailNovel, false);
  }

  //
  addOrUpdateNovel(vm, {bool onUpdate = false, int? idNovel}) async {
    setBusy(true);

    List<int> agesId = [];
    List<int> genresId = [];

    agesMap.forEach((key, value) {
      if (value) {
        agesId.add(key);
      }
    });

    genresMap.forEach((key, value) {
      if (value) {
        genresId.add(key);
      }
    });

    try {
      var apiResponse;

      if (onUpdate) {
        apiResponse = await writeRequest.updateNovel(
            idNovel!,
            novelName.text,
            'ongoing',
            agesId,
            genresId,
            synopsis.text,
            selectedNovelCover == null ? null : File(selectedNovelCover!.path));
      } else {
        apiResponse = await writeRequest.createNovel(novelName.text, agesId,
            genresId, synopsis.text, File(selectedNovelCover!.path));

        novelId = apiResponse['data']['novel']['id'];
        notifyListeners();
      }

      print('resp create novel: ${apiResponse['message']}');

      showDialogResponse(apiResponse['message'].toString(), (value) {
        if (!onUpdate) {
          navToWriteChapter('create', vm);
        }
        // viewContext?.navigator?.pop();
      });

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
      showToast(msg: "Ops, got error: $error");
    }

    setBusy(false);

    return 'done';
  }


  void handleCheckbox(bool? val){
    locked = !locked;
    notifyListeners();
  }


  addNewChapter(status, {int? idNovel}) async {
    setBusyForObject(status == 'draft' ? chapterNumber : chapterName, true);
    // print('chapter ${txt}, id $idNovel');

    try {

      var txtContent = await chapterContent.getText();

      final apiResponse = await writeRequest.addChapterNovel(
        novelId: idNovel!,
        chapterTitle: chapterName.text,
        bab: chapterNumber.text,
        coin: locked ? 1 : 0,
        status: status,
        content: txtContent,
      );

      showDialogResponse(apiResponse['message'].toString(), (value) {
        viewContext?.navigator?.pop();
        // viewContext?.navigator?.pop();
      });

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
      showToast(msg: "Ops, got error: $error");
    }

    setBusyForObject(status == 'draft' ? chapterNumber : chapterName, false);
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

  //
  fetchGenres() async {
    setBusyForObject(genres, true);
    try {
      genres = await genresRequest.getGenres();

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    setBusyForObject(genres, false);
  }

  //
  fetchAges() async {
    setBusyForObject(ages, true);
    try {
      ages = await agesRequest.getAges();

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    setBusyForObject(ages, false);
  }

  void handleSelectGenre(id, action) {
    genresMap.putIfAbsent(id, () => action);
    genresMap.update(id, (value) => action);
    notifyListeners();
  }

  void handleSelectAge(id, action) {
    agesMap.putIfAbsent(id, () => action);
    agesMap.update(id, (value) => action);
    notifyListeners();
  }

  //nav functions

  //fromNav = create
  navToWriteChapter(fromNav, vm) {
    if (fromNav == 'create') {
      viewContext?.navigator
          ?.pushReplacementNamed(AppRoutes.writeChapterRoute, arguments: vm);
    } else {
      viewContext?.navigator
          ?.pushNamed(AppRoutes.writeChapterRoute, arguments: vm);
    }
  }

  //
  navShowAllChapter(vm) {
    viewContext?.navigator
        ?.pushNamed(AppRoutes.listChapterRoute, arguments: vm);
  }
}
