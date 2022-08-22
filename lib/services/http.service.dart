import 'dart:io';
import 'package:dio/dio.dart';
import 'package:read_novel/constants/api.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.service.dart';

class HttpService {
  String host = Api.baseUrl;
  Dio dio = Dio();
  SharedPreferences? prefs;

  Future<Map<String, String>> getHeaders() async {
    final userToken = await AuthServices.getAuthBearerToken();
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $userToken",
    };
  }

  //for get api calls
  Future<Response?> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    bool includeHeaders = true,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";

    print('CALLING API: $uri');

    //preparing the post options if header is required
    final mOptions = !includeHeaders
        ? null
        : Options(
            headers: await getHeaders(),
          );

    Response response;

    try {
      response = await dio.get(
        uri,
        options: mOptions,
        queryParameters: queryParameters,
      );
    } on DioError catch(error) {
      response = formatDioException(error);
    }

    return response;
  }

  //for post api calls
  Future<Response> post(
      String url,
      body, {
        bool includeHeaders = true,
      }) async {
    //preparing the api uri/url
    String uri = "$host$url";

    print('CALLING API: $uri');

    //preparing the post options if header is required
    final mOptions = !includeHeaders
        ? null
        : Options(
      headers: await getHeaders(),
    );

    Response response;

    try {
      response = await dio.post(
        uri,
        data: body,
        options: mOptions,
      );
    } on DioError catch(error) {
      response = formatDioException(error);
    }

    return response;

    // return
  }

  Response formatDioException(DioError ex) {
    Response response = Response(requestOptions: ex.requestOptions);
    response.statusCode = 400;
    try {
      if (ex.type == DioErrorType.connectTimeout) {
        response.data = {
          "message":
              "Connection timeout. Please check your internet connection and try again",
        };
      } else {
        response.data = {
          "message": ex.message,
        };
      }
    } catch (error) {
      response.statusCode = 400;
      response.data = {
        "message": error.toString(),
      };
    }

    return response;
  }
}
