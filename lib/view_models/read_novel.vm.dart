import 'package:flutter/material.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:read_novel/widgets/bottom_sheets/chapters_bottom_sheet.dart';

class ReadNovelViewModel extends MyBaseViewModel {
  ReadNovelViewModel(BuildContext context){
    viewContext = context;
  }

  @override
  void initialise(){

  }

  openAvailableChapters() {
    chaptersBottomSheet(viewContext!);
  }
}