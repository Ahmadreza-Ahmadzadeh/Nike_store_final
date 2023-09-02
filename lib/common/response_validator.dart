import 'package:dio/dio.dart';

import 'appExeption.dart';

mixin ResponseValidator {
  void validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
