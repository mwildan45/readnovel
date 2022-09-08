import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/models/novel_read_chapter.model.dart';
import 'package:read_novel/services/http.service.dart';

class NovelDetailRequest extends HttpService {

  Future<DetailNovel> getNovelDetail(Map params) async {
    final apiResult = await post(Api.getNovelDetail, params);
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return DetailNovel.fromJson(apiResponse.data);
    } else {
      throw apiResponse.message;
    }
  }

  Future<String> handleBookmark(Map params) async {
    final apiResult = await post(Api.handleBookmark, params);
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.body['message'];
    } else {
      throw apiResponse.message;
    }
  }

}