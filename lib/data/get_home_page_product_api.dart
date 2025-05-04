import 'dart:convert';

import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/product_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/network/api_hundler.dart';
import 'package:app/network/network_urls.dart';

class GetHomePageProductApi {
  static Future<BaseResponse<List<ProductModel>>> callApi() async {
    ApiHandler apiHandler = ApiHandler(
      baseUrl: NetworkURLs.getApiServer(),
      defaultHeaders: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${getIt.get<UserModel>().Token}',
        'lang': LocalizationService.getCurrentLocale().languageCode
      },
    );

    try {
      Map<String, dynamic> response = await apiHandler.get(
        "/products/productsViewHomePage",
      );
      BaseResponse<List<ProductModel>> baseResponse =
          BaseResponse<List<ProductModel>>.fromMap(
              response,
              (p0) =>
                  (p0 as List).map((e) => ProductModel.fromMap(e)).toList());
      return baseResponse;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
