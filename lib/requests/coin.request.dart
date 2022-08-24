import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/coins_topup.model.dart';
import 'package:read_novel/services/http.service.dart';

class CoinRequest extends HttpService{

  Future<List<CoinsTopUp>> getCoinTopUp() async {
    final apiResult = await post(Api.getCoinsTopUp, {});
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

}