import 'dart:ffi';

import 'package:app/components/style_widget.dart';
import 'package:app/data/get_product_details_api.dart';
import 'package:app/data/sign_in_api.dart';
import 'package:app/exceptions/unauthorized_exception.dart';
import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/attribute_model.dart';
import 'package:app/models/base_response.dart' as myBaseResponse;
import 'package:app/models/media_model.dart';
import 'package:app/models/product_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/models/value_model.dart';
import 'package:app/screens/languages_screen%20.dart';
import 'package:app/screens/onBording/on_boarding_screen.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import '../components/dialog_box.dart';

class ProductDetailsScreenController extends GetxController {
  RxBool loading = false.obs;
  late ProductModel productModel;
  Rx<MediaModel>? selectedMedia;
  Rx<Map<AttributeModel, ValueModel>> selectedValues = Rx({});
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

  addValueToSelectedAttributesValues(
      {required ValueModel valueModel,
      required AttributeModel attributeModel}) {
    selectedValues.value[attributeModel] = valueModel;
    update();
  }

  Future loadProductDetails(ProductModel productModel) async {
    try {
      loading(true);
      myBaseResponse.BaseResponse<ProductModel> baseResponse =
          await Future.delayed(Duration(seconds: 3),
              () => GetProductDetailsApi.callApi(productModel: productModel));
      this.productModel = baseResponse.data!;
    } on UnAuthorizedException catch (e) {
      Future.delayed(
          Durations.extralong1, () => Get.offAll(() => SigninScreen()));
    } catch (e) {
      print(e);
      throw e;
    } finally {
      loading(false);
      update();
    }
  }
}
