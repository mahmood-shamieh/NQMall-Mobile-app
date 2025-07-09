import 'package:app/components/dialog_box.dart';
import 'package:app/components/my_text.dart';
import 'package:app/components/style_widget.dart';
import 'package:app/controllers/base_controller.dart';
import 'package:app/controllers/cart_screen_controller.dart';
import 'package:app/data/create_order_api.dart';
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
import 'package:app/models/order_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/models/variation_model.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/screens/order_history_screen.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/theme.dart';
import 'package:app/utils/convert_to_url.dart';
import 'package:app/utils/languages_enum.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';

import '../data/get_cart_details_api.dart';

class CheckOutScreenController extends BaseController {
  RxBool loading = false.obs;
  CartModel cartModel = getIt.get<CartModel>();
  Rx<List<CartItemModel>> itemsToDelete = Rx([]);
  CheckOutScreenController({required this.cartModel});
  TextEditingController mobile = TextEditingController();
  TextEditingController note = TextEditingController();
  Rx<String?> errorMobile = null.obs;
  Rx<String?> errorNote = null.obs;
  @override
  void onInit() {
    // getCartDetails();
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
    for (var e in cartModel.CartItems!) {
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
    for (var e in cartModel.CartItems!) {
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

  Future createOrderAction() async {
    GetStorage getStorage = getIt.get<GetStorage>();
    if (getStorage.read(LocalStorageKeys.userModelKey.key) == null) return;
    try {
      loading(true);
      update();
      BaseResponse<OrderModel> baseResponse = await CreateOrderApi.callApi(
          userModel: getIt.get<UserModel>(),
          cartModel: cartModel,
          mobile: mobile.text.trim(),
          note: note.text.trim());
      OrderModel orderModel = baseResponse.data!;
      CartScreenController cartScreenController =
          Get.find<CartScreenController>();
      cartScreenController.onInit();
      Get.back();
      Get.to(() => OrderHistoryScreen());
    } on UnAuthorizedException catch (e) {
      Future.delayed(
          Durations.extralong1, () => Get.offAll(() => SigninScreen()));
    } catch (e) {
      if (e is ViewException) {
        ViewException viewException = e;
        if (viewException.statusCode == 409) {
          VariationModel variationModel =
              VariationModel.fromMap(viewException.data['variation']);

          Get.dialog(
            DialogBox(
              title: 'orderScreen.canNotProceed'.tr,
              titleAlignment: TextAlign.center,
              body: Container(
                // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                // decoration: BoxDecoration(
                //     color: MyTheme.offWhiteColor,
                //     borderRadius: BorderRadius.circular(MyTheme.buttonsRadius)),
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        MyTheme.buttonsRadius,
                      ),
                      child: Image(
                        width: 70,
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          "${NetworkURLs.getMediaServer()}${variationModel.product!.media!.first.URL.toString().convertToUrl()}",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: LocalizationService.getCurrentLocale()
                                        .languageCode ==
                                    "ar"
                                ? variationModel.product!.NameAr.toString()
                                : variationModel.product!.NameEn.toString(),
                            color: MyTheme.textColor,
                          ),
                          Row(
                            children: variationModel.Values!.map((e) {
                              return e.attribute!.Type.toString() == "list" ||
                                      e.attribute!.Type.toString() == "items"
                                  ? Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          end: 6),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: MyTheme.mainColor,
                                        borderRadius: BorderRadius.circular(
                                          MyTheme.buttonsRadius,
                                        ),
                                      ),
                                      child: MyText(
                                        text: (LocalizationService
                                                            .getCurrentLocale()
                                                        .countryCode ==
                                                    'ar'
                                                ? e.ValueAr
                                                : e.ValueEn)
                                            .toString(),
                                        color: MyTheme.offWhiteColor,
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          end: 6),
                                      width: 60,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MyTheme.buttonsRadius),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            "${NetworkURLs.getMediaServer()}${LocalizationService.getCurrentLocale().countryCode == "ar" ? e.ValueAr : e.ValueEn}",
                                          ),
                                        ),
                                      ),
                                    );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          MyText(
                            text:
                                "${'orderScreen.availbleQTY'.tr}: ${variationModel.Stock}",
                            color: MyTheme.textColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              message:
                  "${viewException.message.toString()}\n${'orderScreen.canNotProceedMessage'.tr} ${'orderScreen.canNotProceedMessage2'.tr}",
              cancelText: 'unauthorizedDialog.close'.tr,
            ),
          );
        }

        return;
      }
      ;
      rethrow;
    } finally {
      loading(false);
      update();
    }
  }
}
