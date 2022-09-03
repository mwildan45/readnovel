import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/coins_topup.model.dart';
import 'package:read_novel/models/ipaymu.model.dart';
import 'package:read_novel/services/http.service.dart';

class CoinRequest extends HttpService{

  Future<List<CoinsTopUp>> getListAvailableCoinsTopUp() async {
    final apiResult = await post(Api.getListAvailableCoinsTopUp, {});
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      var data = <CoinsTopUp>[];
      apiResponse.data.forEach((v) {
        data.add(CoinsTopUp.fromJson(v));
      });
      return data;
    } else {
      throw apiResponse.message;
    }
  }

  Future<iPaymuResponse> buyCoin({required int coinId, required String token}) async {
    final apiResult = await post(Api.buyCoin, {
      'coinID': coinId,
      'valToken': token,
    });
    final apiResponse = ApiResponse.fromResponse(apiResult, hasDataObject: false);
    if (apiResponse.allGood) {
      return iPaymuResponse.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message;
    }
  }

  Future<ApiResponse> buyChapter({required int chapterId, required String token}) async {
    final apiResult = await post(Api.buyChapter, {
      'chapter_id': chapterId,
      'valToken': token,
    });
    final apiResponse = ApiResponse.fromResponse(apiResult, hasDataObject: false);
    if (apiResponse.allGood) {
      return apiResponse;
    } else {
      throw apiResponse.message;
    }
  }

}