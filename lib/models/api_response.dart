import 'package:read_novel/utils/custom_exception.dart';

class ApiResponse {
  int get totalDataCount => body["meta"]["total"];
  int get totalPageCount => body["pagination"]["total_pages"];
  dynamic get data => hasDataObject ? body["data"] : body;
  // Just a way of saying there was no error with the request and response return
  bool get allGood => errors!.isEmpty;
  bool hasError() => errors!.isNotEmpty;
  bool hasData() => data != null;
  int code;
  String? status;
  String message;
  dynamic body;
  List? errors;
  bool hasDataObject;

  ApiResponse({
    required this.code,
    required this.message,
    this.status,
    this.body,
    this.errors,
    this.hasDataObject = true,
  });

  factory ApiResponse.fromResponse(dynamic response, {bool hasDataObject = true}) {

    int code = response.statusCode;
    dynamic body = response.data; // Would mostly be a Map
    List errors = [];
    dynamic message;
    dynamic status;

    print('RESPONSE API: ${response.data}');

    switch (response.statusCode) {
      case 200:
        print('CODE: $code');

        try {
          status = body['status'];
          message = body["message"] ?? body["Message"];
        } catch (error) {
          throw BadRequestException("Message response failed to get ==> $error");
          // print("Message response failed to get ==> $error");
        }

        return ApiResponse(
            code: code,
            status: status,
            message: message,
            body: body,
            errors: errors,
            hasDataObject: hasDataObject
        );

      case 400:
        throw BadRequestException(response.data.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
        throw UnauthorisedException(response.data.toString());
      default:
        throw FetchDataException('Error terjadi saat melakukan koneksi dengan statusCode : ${response.statusCode}');
    }

    // switch (code) {
    //   case 200:
    //     String status = response.data['status'];
    //     if(hasDataObject) {
    //       try {
    //         message = body["message"];
    //       } catch (error) {
    //         print("Message reading error ==> $error");
    //       }
    //     }
    //     break;
    //
    //   default:
    //     message = body["message"] ??
    //         "Whoops! Something went wrong, please contact support.";
    //     errors.add(message);
    //     break;
    // }

    // return ApiResponse(
    //     code: code,
    //     message: message,
    //     body: body,
    //     errors: errors,
    //     hasDataObject: hasDataObject
    // );
  }
}
