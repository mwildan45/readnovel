import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/novel_detail.model.dart';
import 'package:read_novel/models/novel_read_chapter.model.dart';
import 'package:read_novel/services/http.service.dart';

class ChapterRequest extends HttpService {

  Future<List<Chapters>> getNovelChaptersList({required int idNovel, required String token}) async {
    final apiResult = await post(Api.getNovelChaptersList, {
      'novel_id': idNovel,
      'valToken': token
    });

    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      var data = <Chapters>[];
      apiResponse.data.forEach((v) {
        data.add(Chapters.fromJson(v));
      });
      return data;
    } else {
      throw apiResponse.message;
    }
  }

  Future<HeaderReadNovelChapter> getReadNovelChapter(Map params) async {
    final apiResult = await post(Api.getReadNovelChapter, params);
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return HeaderReadNovelChapter.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message;
    }
  }

}