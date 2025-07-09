import 'dart:convert';

import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/cart_item_model.dart';
import 'package:app/models/cart_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/models/variation_model.dart';
import 'package:app/network/api_hundler.dart';
import 'package:app/network/network_urls.dart';

class AddToCartApi {
  static Future<BaseResponse<CartModel>> callApi(
      {required VariationModel variationModel}) async {
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
        "variations": [
          {
            "PriceAtAddition": variationModel.Price,
            "Quantity": variationModel.orderQTY,
            "variationId": variationModel.Id,
            "productId": variationModel.productId
          }
        ]
      };
      Map<String, dynamic> response =
          await apiHandler.put("/carts/add", body: request);
      BaseResponse<CartModel> baseResponse = BaseResponse<CartModel>.fromMap(
          response, (p0) => CartModel.fromMap(p0));
      return baseResponse;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
