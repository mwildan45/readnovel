import 'dart:io';

import 'package:dio/dio.dart';
import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/services/http.service.dart';

class WriteRequest extends HttpService {

  Future createNovel(String title, List<int> ages, List<int> genres, String sinopsis, File cover) async {
    final userToken = await AuthServices.getAuthBearerToken();
    final apiResult = await postWithFiles(
      Api.createNovel,
      {
        'valToken': userToken,
        'title': title,
        'ages[]': ages,
        'genre[]': genres,
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

  Future<List<Novel>> getMyNovels() async {
    final token = await AuthServices.getAuthBearerToken();
    final apiResult = await post(Api.getBookmarks, {'token': token});
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

}
