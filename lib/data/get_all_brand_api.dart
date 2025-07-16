import 'dart:convert';

import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/brand_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/network/api_hundler.dart';
import 'package:app/network/network_urls.dart';

class GetAllBrandApi {
  static Future<BaseResponse<List<BrandModel>>> callApi() async {
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
        "/brands/brandsView",
      );
      BaseResponse<List<BrandModel>> baseResponse =
          BaseResponse<List<BrandModel>>.fromMap(response,
              (p0) => (p0 as List).map((e) => BrandModel.fromMap(e)).toList());
      return baseResponse;
    } catch (e) {
      rethrow;
    }
  }
}
