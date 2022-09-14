import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/author.model.dart';
import 'package:read_novel/services/http.service.dart';

class AuthorRequest extends HttpService {
  Future<List<Author>> getAuthors() async {
    final apiResult = await post(Api.authors, {});
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      var data = <Author>[];
      apiResponse.data.forEach((v) {
        data.add(Author.fromJson(v));
      });
      return data;
    } else {
      throw apiResponse.message;
    }
  }

  Future<ApiResponse> getDetailAuthor(int id) async {
    final apiResult = await post(Api.detailAuthor, {'user_id': id});
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse;
    } else {
      throw apiResponse.message;
    }
  }
}