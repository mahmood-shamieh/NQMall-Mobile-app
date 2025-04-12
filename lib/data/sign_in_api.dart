import 'dart:convert';

import 'package:app/localization_service.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/user_model.dart';
import 'package:app/network/api_hundler.dart';
import 'package:app/network/network_urls.dart';

class SigninApi {
  static Future<BaseResponse<UserModel>> callApi(
      {required String username, required String passowrd}) async {
    ApiHandler apiHandler = ApiHandler(
      baseUrl: NetworkURLs.getApiServer(),
      defaultHeaders: {
        'Content-Type': 'application/json',
        'lang': LocalizationService.getCurrentLocale().languageCode
      },
    );
    Map<String, String> request = {"username": username, "password": passowrd};

    try {
      Map<String, dynamic> response =
          await apiHandler.post("/users/login", body: request);
      BaseResponse<UserModel> baseResponse = BaseResponse<UserModel>.fromMap(
          response, (p0) => UserModel.fromMap(p0));
      return baseResponse;
    } catch (e) {
      rethrow;
    }
  }
}
