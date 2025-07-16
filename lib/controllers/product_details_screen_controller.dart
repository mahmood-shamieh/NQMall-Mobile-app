import 'package:app/components/my_snack_bar.dart';
import 'package:app/components/style_widget.dart';
import 'package:app/controllers/cart_screen_controller.dart';
import 'package:app/data/add_to_cart_api.dart';
import 'package:app/data/get_product_details_api.dart';
import 'package:app/data/remove_from_cart_api.dart';
import 'package:app/data/remove_from_cart_by_variation_id_api.dart';
import 'package:app/data/sign_in_api.dart';
import 'package:app/exceptions/unauthorized_exception.dart';
import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/attribute_model.dart';
import 'package:app/models/base_response.dart' as myBaseResponse;
import 'package:app/models/cart_model.dart';
import 'package:app/models/media_model.dart';
import 'package:app/models/product_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/models/value_model.dart';
import 'package:app/models/variation_model.dart';
import 'package:app/screens/languages_screen%20.dart';
import 'package:app/screens/onBording/on_boarding_screen.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../components/dialog_box.dart';

class ProductDetailsScreenController extends GetxController {
  RxBool loading = false.obs;
  late ProductModel productModel;
  Rx<MediaModel>? selectedMedia;
  Rx<Map<AttributeModel, ValueModel>> selectedValues = Rx({});
  Rx<VariationModel?> matchedVariation = Rx(null);
  ProductDetailsScreenController({required this.productModel});
  @override
  void onInit() async {
    loadProductDetails(productModel);
    super.onInit();
  }

  setSelectedMediaToPreview({required MediaModel mediaModel}) {
    selectedMedia = Rx(mediaModel);
    update();
  }

  resetPurchaseProcess() {
    selectedValues.value = {};
    matchedVariation.value = null;
    update();
  }

  addValueToSelectedAttributesValues(
      {required ValueModel valueModel,
      required AttributeModel attributeModel}) {
    selectedValues.value[attributeModel] = valueModel;
    // find the matched variation to the selected values
    if (selectedValues.value.length == productModel.attributes?.length) {
      selectedValues.value = selectedValues.value
          .map((key, value) => MapEntry(key, value.copyWith(attribute: key)));
      for (VariationModel variationModel in productModel.variations ?? []) {
        Map<int, bool> checkList = Map.fromEntries(selectedValues.value.values
            .map((e) => MapEntry(int.parse(e.Id.toString()), false)));
        for (ValueModel value in selectedValues.value.values) {
          checkList[value.Id!] = (variationModel.Values ?? [])
              .where((element) => element.Id == value.Id)
              .isNotEmpty;
          if (checkList.values.every((element) => element)) {
            matchedVariation.value = variationModel.copyWith(
                Values:
                    selectedValues.value.values.map((value) => value).toList());
          }
        }
      }
    }
    update();
  }

  Future loadProductDetails(ProductModel productModel) async {
    try {
      loading(true);
      myBaseResponse.BaseResponse<ProductModel> baseResponse =
          await GetProductDetailsApi.callApi(productModel: productModel);
      this.productModel = baseResponse.data!;
      this.productModel.variations = (this.productModel.variations ?? [])
          .map((e) => e.copyWith(productId: this.productModel.Id))
          .toList();
    } on UnAuthorizedException catch (e) {
      Future.delayed(
          Durations.extralong1, () => Get.offAll(() => SigninScreen()));
    } catch (e) {
      rethrow;
    } finally {
      loading(false);
      update();
    }
  }

  Future addMatchedVariationToCart() async {
    try {
      loading(true);
      update();
      myBaseResponse.BaseResponse<CartModel> baseResponse =
          await AddToCartApi.callApi(variationModel: matchedVariation.value!);
      CartModel cartModel = baseResponse.data!;
      if (getIt.isRegistered<CartModel>()) {
        getIt.unregister<CartModel>();
      }
      getIt.registerSingleton(cartModel);
      Get.dialog(
        Align(
          alignment: Alignment.topCenter,
          child: MySnackBar(
            title: "ProductDetailsScreen.successTitle".tr,
            message: "ProductDetailsScreen.addedToCart".tr,
            actionLabel: "ProductDetailsScreen.goToCart".tr,
            onAction: () {
              try {
                Get.back();
                Get.back();

                PersistentTabController persistentTabController =
                    getIt.get<PersistentTabController>();
                persistentTabController.jumpToTab(1);
                var cartScreenController = Get.find<CartScreenController>();
                cartScreenController.onInit();
              } catch (e) {}
            },
            closeAction: () => Get.back(),
            closeLabel: "ProductDetailsScreen.close".tr,
          ),
        ),
        barrierColor: Colors.transparent,
      );
    } on UnAuthorizedException catch (e) {
      Future.delayed(
          Durations.extralong1, () => Get.offAll(() => SigninScreen()));
    } catch (e) {
      rethrow;
    } finally {
      loading(false);
      update();
    }
  }

  Future removeMatchedVariationFromCart() async {
    try {
      loading(true);
      update();
      myBaseResponse.BaseResponse<CartModel> baseResponse =
          await RemoveFromCartByVariationIdApi.callApi(
        variations: [matchedVariation.value!],
        userModel: getIt.get<UserModel>(),
      );
      CartModel cartModel = baseResponse.data!;
      if (getIt.isRegistered<CartModel>()) {
        getIt.unregister<CartModel>();
      }
      getIt.registerSingleton(cartModel);
    } on UnAuthorizedException catch (e) {
      Future.delayed(
          Durations.extralong1, () => Get.offAll(() => SigninScreen()));
    } catch (e) {
      rethrow;
    } finally {
      loading(false);
      update();
    }
  }

  increaseOrderQTY() {
    int qty = int.parse(matchedVariation.value!.Stock.toString());
    matchedVariation.value!.orderQTY =
        matchedVariation.value!.orderQTY + 1 <= qty
            ? matchedVariation.value!.orderQTY + 1
            : matchedVariation.value!.orderQTY;
    update();
  }

  decreaseOrderQTY() {
    matchedVariation.value!.orderQTY = matchedVariation.value!.orderQTY - 1 > 0
        ? matchedVariation.value!.orderQTY - 1
        : matchedVariation.value!.orderQTY;
    update();
  }
}
