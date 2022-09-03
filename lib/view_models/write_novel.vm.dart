import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/ages.model.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/genres.model.dart';
import 'package:read_novel/models/my_novel_detail.model.dart';
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

  GenresRequest genresRequest = GenresRequest();
  AgesRequest agesRequest = AgesRequest();
  WriteRequest writeRequest = WriteRequest();
  MyNovelDetail? myNovelDetail;
  List<Genres>? genres;
  List<Ages>? ages;
  var agesMap = <int, bool>{};
  var genresMap = <int, bool>{};
  int? novelId;

  TextEditingController novelName = TextEditingController();
  TextEditingController synopsis = TextEditingController();

  XFile? selectedNovelCover;

  @override
  void initialise() {
    fetchAges();
    fetchGenres();
  }

  //
  onImageSelected(XFile file) {
    selectedNovelCover = file;
    notifyListeners();
  }

  getNovelDetail(idNovel) async {
    setBusyForObject(myNovelDetail, true);

    fetchAges();
    fetchGenres();

    try {
      myNovelDetail = await writeRequest.getMyNovelDetail({
        'novel_id': idNovel,
        'valToken': await AuthServices.getAuthBearerToken(),
      });

      novelName = TextEditingController(text: myNovelDetail?.title);
      synopsis = TextEditingController(text: myNovelDetail?.synopsis);
      myNovelDetail?.age?.forEach((element) {
        agesMap.putIfAbsent(element.toInt(), () => true);
      });
      myNovelDetail?.genre?.forEach((element) {
        genresMap.putIfAbsent(element.toInt(), () => true);
      });
      notifyListeners();

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }
    setBusyForObject(myNovelDetail, false);
  }

  //
  addOrUpdateNovel(vm, {bool onUpdate = false, int? idNovel}) async {
    if(selectedNovelCover == null){
      showToast(msg: 'Pilih cover terlebih dahulu!');
    } else if(agesMap.isEmpty) {
      showToast(msg: 'Pilih peringkat konten!');
    } else if(genresMap.isEmpty) {
      showToast(msg: 'Pilih minimal satu genre!');
    } else{
      if (formKey.currentState!.validate()) {
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
          ApiResponse apiResponse;

          if (onUpdate) {
            apiResponse = await writeRequest.updateNovel(
                idNovel!,
                novelName.text,
                'ongoing',
                agesId,
                genresId,
                synopsis.text,
                selectedNovelCover == null ? null : File(
                    selectedNovelCover!.path));
          } else {
            apiResponse = await writeRequest.createNovel(novelName.text, agesId,
                genresId, synopsis.text, File(selectedNovelCover!.path));

            novelId = apiResponse.data['novel']['id'];
            notifyListeners();
          }

          print('resp create novel: ${apiResponse.message}');

          showDialogResponse(apiResponse.message.toString(), (value) {
            if (!onUpdate) {
              navToWriteChapter(novelId!);
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
      }
    }

    return 'done';
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
  navToWriteChapter(int idNovel) {
    viewContext?.navigator
        ?.pushReplacementNamed(AppRoutes.writeChapterRoute, arguments: {
      'idNovel': idNovel,
      'idChapter': null,
      'onUpdate': false,
    });
  }

  //
  navShowAllChapter(int idNovel) {
    viewContext?.navigator
        ?.pushNamed(AppRoutes.listChapterRoute, arguments: idNovel);
  }

  onBackPressed() {
    //
    viewContext?.navigator?.pop(true);
  }
}
