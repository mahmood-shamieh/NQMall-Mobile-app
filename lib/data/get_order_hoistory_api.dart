import 'dart:convert';

import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/brand_model.dart';
import 'package:app/models/cart_item_model.dart';
import 'package:app/models/cart_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/order_model.dart';
import 'package:app/models/product_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/models/variation_model.dart';
import 'package:app/network/api_hundler.dart';
import 'package:app/network/network_urls.dart';

class GetOrderHistoryApi {
  static Future<BaseResponse<List<OrderModel>>> callApi(
      {required UserModel userModel}) async {
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
        "/orders/",
      );
      BaseResponse<List<OrderModel>> baseResponse =
          BaseResponse<List<OrderModel>>.fromMap(response, (p0) {
        return (p0 as List).map((temp) => OrderModel.fromMap(temp)).toList();
      });
      return baseResponse;
    } catch (e) {
      rethrow;
    }
  }
}
