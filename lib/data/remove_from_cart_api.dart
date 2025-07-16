import 'dart:convert';

import 'package:app/localization_service.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/cart_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/network/api_hundler.dart';
import 'package:app/network/network_urls.dart';

import '../models/cart_item_model.dart';

class RemoveFromCartApi {
  static Future<BaseResponse<CartModel>> callApi(
      {required UserModel userModel,
      required List<CartItemModel> cartItems}) async {
    ApiHandler apiHandler = ApiHandler(
      baseUrl: NetworkURLs.getApiServer(),
      defaultHeaders: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userModel.Token}',
        'lang': LocalizationService.getCurrentLocale().languageCode
      },
    );
    try {
      Map<String, dynamic> response = await apiHandler.delete("/carts",
          body: {"cartItems": cartItems.map((e) => e.Id).toList()});
      BaseResponse<CartModel> baseResponse = BaseResponse<CartModel>.fromMap(
          response, (p0) => CartModel.fromMap(p0));
      return baseResponse;
    } catch (e) {
      rethrow;
    }
  }
}
