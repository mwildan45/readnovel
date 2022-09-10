import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/services/http.service.dart';

class IncomeRequest extends HttpService {
  Future<ApiResponse> claimIncome({required String amount, required String token}) async {
    final apiResult = await post(Api.claimIncome, {
      'valToken': token,
      'amount': amount
    });
    final apiResponse = ApiResponse.fromResponse(apiResult, hasDataObject: false);
    if (apiResponse.allGood) {
      return apiResponse;
    } else {
      throw apiResponse.message;
    }
  }
}