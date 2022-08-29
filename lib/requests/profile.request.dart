import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/faq.model.dart';
import 'package:read_novel/models/profile.model.dart';
import 'package:read_novel/services/http.service.dart';

class ProfileRequest extends HttpService{


  Future<Profile> getProfileUser(String token) async {
    final apiResult = await post(Api.getProfile, {'valToken': token});
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      var data = Profile.fromJson(apiResponse.data);
      return data;
    } else {
      throw apiResponse.message;
    }
  }

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