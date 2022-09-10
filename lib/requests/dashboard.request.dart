
import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/banner.model.dart';
import 'package:read_novel/models/genres.model.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/models/novels_dashboard.model.dart';
import 'package:read_novel/services/http.service.dart';

class DashboardRequest extends HttpService {

  Future<BannerHeader> getBanners() async {
    final apiResult = await post(Api.getBanner, {});
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return BannerHeader.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message;
    }
  }

  Future<ListNovelsDashboard> getNovelsDashboard() async {
    final apiResult = await post(Api.getListNovelsDashboard, {});
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return ListNovelsDashboard.fromJson(apiResponse.body['data']);
    } else {
      throw apiResponse.message;
    }
  }

  Future<List<Novel>> getNovelsPerGenres(int idGenre) async {
    final apiResult = await post(Api.getNovelsPerGenres, {'id': idGenre});
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

  Future<List<Novel>> getNovelsPerSection(String type) async {
    final apiResult = await post(Api.getNovelsPerSection, {'type': type});
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

  Future<List<Novel>> searchNovel(String title) async {
    final apiResult = await post(Api.searchNovel, {'title': title});
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