import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/genres.model.dart';
import 'package:read_novel/services/http.service.dart';

class GenresRequest extends HttpService {
  Future<List<Genres>> getGenres() async {
    final apiResult = await post(Api.getGenres, {});
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      var data = <Genres>[];
      apiResponse.data.forEach((v) {
        data.add(Genres.fromJson(v));
      });
      return data;
    } else {
      throw apiResponse.message;
    }
  }
}