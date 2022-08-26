import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/services/http.service.dart';

class LibraryRequest extends HttpService {

  Future<List<Novel>> getBookmark(params) async {
    final apiResult = await post(Api.getBookmarks, params);
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