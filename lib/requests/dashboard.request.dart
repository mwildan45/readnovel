
import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/banner.model.dart';
import 'package:read_novel/models/genre.model.dart';
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

  Future<List<Genre>> getGenres() async {
    final apiResult = await post(Api.getBanner, {});
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      var data = <Genre>[];
      apiResponse.body['data'].forEach((v) {
        data.add(Genre.fromJson(v));
      });
      return data;
    } else {
      throw apiResponse.message;
    }
  }
}