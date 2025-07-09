import 'dart:convert';

import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/brand_model.dart';
import 'package:app/models/cart_item_model.dart';
import 'package:app/models/cart_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/product_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/models/variation_model.dart';
import 'package:app/network/api_hundler.dart';
import 'package:app/network/network_urls.dart';

class SearchProductsApi {
  static Future<BaseResponse<List<ProductModel>>> callApi(
      {List<CategoryModel>? categories,
      List<BrandModel>? brands,
      String? searchQuery,
      required int page,
      required int limit}) async {
    ApiHandler apiHandler = ApiHandler(
      baseUrl: NetworkURLs.getApiServer(),
      defaultHeaders: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getIt.get<UserModel>().Token}',
        'lang': LocalizationService.getCurrentLocale().languageCode
      },
    );
    try {
      Map<String, dynamic> request = {
        "page": page,
        "limit": limit,
        "categoryId": categories == null || categories.isEmpty
            ? null
            : categories.map((e) => e.Id).toList(),
        "brandId": brands == null || brands.isEmpty
            ? null
            : brands.map((e) => e.Id).toList(),
        "searchQuery":
            searchQuery == null || searchQuery.isEmpty ? null : searchQuery
      };
      Map<String, dynamic> response =
          await apiHandler.post("/products/", body: request);
      BaseResponse<List<ProductModel>> baseResponse =
          BaseResponse<List<ProductModel>>.fromMap(
              response,
              (p0) => (p0['data'] as List)
                  .map((temp) => ProductModel.fromMap(temp))
                  .toList());

      return baseResponse;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
