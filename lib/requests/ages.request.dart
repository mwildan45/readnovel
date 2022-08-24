import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/ages.model.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/services/http.service.dart';

class AgesRequest extends HttpService {

  Future<List<Ages>> getAges() async {
    final apiResult = await post(Api.getAges, {});
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      var data = <Ages>[];
      apiResponse.data.forEach((v) {
        data.add(Ages.fromJson(v));
      });
      return data;
    } else {
      throw apiResponse.message;
    }
  }

}