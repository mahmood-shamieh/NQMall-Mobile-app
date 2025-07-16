import 'dart:convert';

import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/product_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/network/api_hundler.dart';
import 'package:app/network/network_urls.dart';

class GetProductDetailsApi {
  static Future<BaseResponse<ProductModel>> callApi(
      {required ProductModel productModel}) async {
    ApiHandler apiHandler = ApiHandler(
      baseUrl: NetworkURLs.getApiServer(),
      defaultHeaders: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getIt.get<UserModel>().Token}',
        'lang': LocalizationService.getCurrentLocale().languageCode
      },
    );

    try {
      Map<String, dynamic> response = await apiHandler.get(
        "/products/${productModel.Id.toString()}",
      );
      BaseResponse<ProductModel> baseResponse =
          BaseResponse<ProductModel>.fromMap(
              response, (p0) => ProductModel.fromMap(p0));
      return baseResponse;
    } catch (e) {
      rethrow;
    }
  }
}
