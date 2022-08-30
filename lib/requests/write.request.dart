import 'dart:io';

import 'package:dio/dio.dart';
import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/services/http.service.dart';

class WriteRequest extends HttpService {
  Future createNovel(String title, List<int> ages, List<int> genres,
      String sinopsis, File cover) async {
    final userToken = await AuthServices.getAuthBearerToken();
    final apiResult = await postWithFiles(
      Api.createNovel,
      {
        'valToken': userToken,
        'title': title,
        'ages[]': ages,
        'genre[]': genres,
        'sinopsis': sinopsis,
        'cover': await MultipartFile.fromFile(cover.path),
      },
    );
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.body;
    } else {
      throw apiResponse.message;
    }
  }

  Future updateNovel(int idNovel, String title, String status, List<int> ages,
      List<int> genres, String sinopsis, File? cover) async {
    final userToken = await AuthServices.getAuthBearerToken();
    final apiResult = await postWithFiles(
      Api.updateNovel,
      {
        'valToken': userToken,
        'novel_id': idNovel,
        'title': title,
        'status': status,
        'ages[]': ages,
        'genre[]': genres,
        'sinopsis': sinopsis,
        'cover':
            cover == null ? null : await MultipartFile.fromFile(cover.path),
      },
    );
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.body;
    } else {
      throw apiResponse.message;
    }
  }

  Future addChapterNovel(
      {required int novelId,
      required String chapterTitle,
      required String bab,
      required int coin,
      required String status,
      required String content}) async {
    final userToken = await AuthServices.getAuthBearerToken();
    final apiResult = await postWithFiles(
      Api.addChapter,
      {
        'valToken': userToken,
        'novel_id': novelId,
        'title': chapterTitle,
        'bab': bab,
        'coin': coin,
        'status': status,
        'content': content,
      },
    );
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.body;
    } else {
      throw apiResponse.message;
    }
  }

  Future<List<Novel>> getMyNovels() async {
    final token = await AuthServices.getAuthBearerToken();
    final apiResult = await post(Api.myNovels, {'valToken': token});
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      var data = <Novel>[];
      apiResponse.data.forEach((v) {
        data.add(Novel.fromJson(v));
      });
      return data;
    } else {
      throw apiResponse.message;
    }
  }

  Future<DetailNovel> getMyNovelDetail(Map params) async {
    final apiResult = await post(Api.myNovelDetail, params);
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return DetailNovel.fromJson(apiResponse.data);
    } else {
      throw apiResponse.message;
    }
  }
}
