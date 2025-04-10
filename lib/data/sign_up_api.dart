import 'dart:convert';

import 'package:app/localization_service.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/user_model.dart';
import 'package:app/network/api_hundler.dart';
import 'package:app/network/network_urls.dart';

class SignupApi {
  static Future<BaseResponse<UserModel>> callApi(
      {required UserModel userModel}) async {
    ApiHandler apiHandler = ApiHandler(
      baseUrl: NetworkURLs.getApiServer(),
      defaultHeaders: {
        'Content-Type': 'application/json',
        'lang': LocalizationService.getCurrentLocale().languageCode
      },
    );
    Map<String, String> request = {
      "Email": userModel.Email.toString(),
      "Password": userModel.PasswordHash.toString(),
      "FullName": userModel.FullName.toString(),
      "Address": userModel.Address.toString(),
      "PhoneNumber": userModel.PhoneNumber.toString(),
      "IsActive": true.toString(),
      "Role": "customer",
    };

    try {
      Map<String, dynamic> response =
          await apiHandler.post("/users/create", body: request);

      BaseResponse<UserModel> baseResponse = BaseResponse<UserModel>.fromMap(
          response, (p0) => UserModel.fromMap(p0));
      return baseResponse;
    } catch (e) {
      rethrow;
    }
  }
}
