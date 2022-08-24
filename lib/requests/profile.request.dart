import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/faq.model.dart';
import 'package:read_novel/services/http.service.dart';

class ProfileRequest extends HttpService{

  Future<List<FAQ>> getFAQ() async {
    final apiResult = await post(Api.getFAQ, {});
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      var data = <FAQ>[];
      apiResponse.data.forEach((v) {
        data.add(FAQ.fromJson(v));
      });
      return data;
    } else {
      throw apiResponse.message;
    }
  }

}