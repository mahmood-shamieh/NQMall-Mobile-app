import 'package:app/components/dialog_box.dart';
import 'package:app/components/style_widget.dart';
import 'package:app/controllers/base_controller.dart';
import 'package:app/data/remove_from_cart_api.dart';
import 'package:app/data/remove_from_cart_api.dart';
import 'package:app/data/sign_in_api.dart';
import 'package:app/exceptions/unauthorized_exception.dart';
import 'package:app/exceptions/view_exception.dart';
import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/cart_item_model.dart';
import 'package:app/models/cart_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/theme.dart';
import 'package:app/utils/languages_enum.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';

import '../data/get_cart_details_api.dart';

class CartScreenController extends BaseController {
  RxBool loading = false.obs;
  CartModel? cartModel;
  Rx<List<CartItemModel>> itemsToDelete = Rx([]);

  @override
  void onInit() {
    getCartDetails();
    super.onInit();
  }

  addAndRemoveToDeletedCArtItems({required CartItemModel cartItemModel}) {
    // print(itemsToDelete.value);
    if (itemsToDelete.value.contains(cartItemModel)) {
      itemsToDelete.value.remove(cartItemModel);
    } else {
      itemsToDelete.value.add(cartItemModel);
    }
    update();
  }

  deleteCartItems() async {
    GetStorage getStorage = getIt.get<GetStorage>();
    if (getStorage.read(LocalStorageKeys.userModelKey.key) == null) return;
    try {
      loading(true);
      update();
      BaseResponse<CartModel> baseResponse = await RemoveFromCartApi.callApi(
          cartItems: itemsToDelete.value, userModel: getIt.get<UserModel>());
      CartModel cartModel = baseResponse.data!;
      if (getIt.isRegistered<CartModel>()) {
        getIt.unregister<CartModel>();
      }
      getIt.registerSingleton<CartModel>(cartModel);
      this.cartModel = cartModel;
      itemsToDelete.value.clear();
    } on UnAuthorizedException catch (e) {
      Future.delayed(
          Durations.extralong1, () => Get.offAll(() => SigninScreen()));
    } catch (e) {
      getIt.registerSingleton<CartModel>(
          CartModel(userId: getIt.get<UserModel>().Id, CartItems: []));
      if (e is ViewException) return;
      rethrow;
    } finally {
      loading(false);
      update();
    }
  }

  incaseAction({required CartItemModel cartItemModel}) {
    if (cartModel == null) return;
    for (var e in cartModel!.CartItems!) {
      if (cartItemModel.Id == e.Id && e.variation != null) {
        int currentQty = e.Quantity!.toInt();
        int stock = int.parse(e.variation!.Stock.toString());
        if (currentQty < stock) {
          e.Quantity = currentQty + 1;
        }
        break;
      }
    }

    update();
  }

  decreaseAction({required CartItemModel cartItemModel}) {
    if (cartModel == null) return;

    for (var e in cartModel!.CartItems!) {
      if (cartItemModel.Id == e.Id && e.variation != null) {
        int currentQty = e.Quantity!.toInt();
        if (currentQty > 1) {
          e.Quantity = currentQty - 1;
        }
        break;
      }
    }

    update();
  }

  Future getCartDetails() async {
    GetStorage getStorage = getIt.get<GetStorage>();
    if (getStorage.read(LocalStorageKeys.userModelKey.key) == null) return;
    try {
      loading(true);
      update();
      BaseResponse<CartModel> baseResponse =
          await GetCartDetailsApi.callApi(userModel: getIt.get<UserModel>());
      CartModel cartModel = baseResponse.data!;
      if (getIt.isRegistered<CartModel>()) {
        getIt.unregister<CartModel>();
      }
      getIt.registerSingleton<CartModel>(cartModel);
      this.cartModel = cartModel;
    } on UnAuthorizedException catch (e) {
      Future.delayed(
          Durations.extralong1, () => Get.offAll(() => SigninScreen()));
    } catch (e) {
      print(e);
      getIt.registerSingleton<CartModel>(
          CartModel(userId: getIt.get<UserModel>().Id, CartItems: []));
      if (e is ViewException) return;
      rethrow;
    } finally {
      loading(false);
      update();
    }
  }
}
