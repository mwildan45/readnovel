import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/models/login.model.dart';
import 'package:read_novel/models/register.model.dart';
import 'package:read_novel/services/http.service.dart';

class AuthRequest extends HttpService {

  Future<Register> register(Map params) async {
    final apiResult = await post(Api.register, params);
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return Register.fromJson(apiResponse.data);
    } else {
      throw apiResponse.message;
    }
  }

  Future<Login> login(Map params) async {
    final apiResult = await post(Api.login, params);
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return Login.fromJson(apiResponse.data);
    } else {
      throw apiResponse.message;
    }
  }

}