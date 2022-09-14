import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_routes.dart';
import 'package:read_novel/models/author.model.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/requests/author.request.dart';
import 'package:read_novel/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthorViewModel extends MyBaseViewModel {
  AuthorViewModel(BuildContext context, this.idAuthor){
    viewContext = context;
  }

  int idAuthor;
  AuthorRequest authorRequest = AuthorRequest();
  List<Novel>? novels;
  Author? author;

  getAuthorDetail() async {
    setBusy(true);
    final apiResp = await authorRequest.getDetailAuthor(idAuthor);

    var data = <Novel>[];
    apiResp.data['novel'].forEach((v) {
      data.add(Novel.fromJson(v));
    });

    author = Author.fromJson(apiResp.data['author']);
    novels = data;
    try {



      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
      viewContext?.showToast(
        msg: "$error",
        bgColor: Colors.red,
      );
    }

    setBusy(false);
  }

  openNovel(int? id, Novel? novel) async {
    final result = await viewContext?.navigator?.pushNamed(
      AppRoutes.detailNovelRoute,
      arguments: novel,
    );
  }

}