import 'dart:io';

import 'package:dio/dio.dart';
import 'package:read_novel/constants/api.dart';
import 'package:read_novel/models/api_response.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/services/http.service.dart';

class RegisterAsWriterRequest extends HttpService {
  Future<ApiResponse> handleBecomeWriter({
    required String nama_asli,
    required String nama_pena,
    required String tanggal_lahir,
    required String nomor_id,
    required File image_id,
    required String alamat,
    required String telepon,
    required String nama_bank,
    required String atas_nama,
    required String rekening,
  }) async {

    final userToken = await AuthServices.getAuthBearerToken();

    final apiResult = await postWithFiles(Api.beAuthor, {
      "valToken": userToken,
      "nama_asli": nama_asli,
      "nama_pena": nama_pena,
      "tanggal_lahir": tanggal_lahir,
      "nomor_id": nomor_id,
      "image_id": await MultipartFile.fromFile(image_id.path),
      "alamat": alamat,
      "telepon": telepon,
      "nama_bank": nama_bank,
      "atas_nama": atas_nama,
      "rekening": rekening
    });

    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.body;
    } else {
      throw apiResponse.message;
    }
  }
}
