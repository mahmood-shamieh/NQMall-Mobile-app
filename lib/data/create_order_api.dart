import 'dart:convert';

import 'package:app/localization_service.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/cart_model.dart';
import 'package:app/models/order_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/network/api_hundler.dart';
import 'package:app/network/network_urls.dart';

import '../models/cart_item_model.dart';

class CreateOrderApi {
  static Future<BaseResponse<OrderModel>> callApi(
      {required UserModel userModel,
      String? mobile,
      String? note,
      required CartModel cartModel}) async {
    ApiHandler apiHandler = ApiHandler(
      baseUrl: NetworkURLs.getApiServer(),
      defaultHeaders: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userModel.Token}',
        'lang': LocalizationService.getCurrentLocale().languageCode
      },
    );
    try {
      Map<String, dynamic> body = {
        "OrderNumber": "",
        "PaymentMethod": "cash_on_delivery",
        "mobile": mobile,
        "Notes": note,
        "orderItems": cartModel.CartItems?.map((e) => {
              "Quantity": e.Quantity,
              "Price": e.PriceAtAddition,
              "SalePrice": null,
              "variationId": e.variation?.Id.toString(),
              "productId": e.product?.Id.toString()
            }).toList()
      };
      Map<String, dynamic> response =
          await apiHandler.put("/orders/create", body: body);
      BaseResponse<OrderModel> baseResponse = BaseResponse<OrderModel>.fromMap(
          response, (p0) => OrderModel.fromMap(p0));
      return baseResponse;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
