
import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/banner.model.dart';
import 'package:read_novel/models/genres.model.dart';
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
}