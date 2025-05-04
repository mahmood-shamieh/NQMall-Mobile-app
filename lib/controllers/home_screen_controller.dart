import 'package:app/data/get_all_category_api.dart';
import 'package:app/data/get_home_page_product_api.dart';
import 'package:app/exceptions/unauthorized_exception.dart';
import 'package:app/main.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/product_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/utils/languages_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../localization_service.dart';
import '../models/base_response.dart';

class HomeScreenController extends GetxController {
  RxBool loadingCategories = false.obs;
  RxBool loadingProducts = false.obs;
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];
  @override
  void onInit() {
    loadCategories();
    loadProducts();
    super.onInit();
  }

  loadCategories() async {
    try {
      loadingCategories(true);
      update();
      BaseResponse<List<CategoryModel>> baseResponse = await Future.delayed(
          Duration(seconds: 1),
          () async => await GetAllCategoriesApi.callApi());
      categories = baseResponse.data ?? [];
      loadingCategories(false);
      update();
    } on UnAuthorizedException catch (e) {
    } catch (e) {
    } finally {
      loadingCategories(false);
      update();
    }
  }

  loadProducts() async {
    try {
      loadingProducts(true);
      update();
      BaseResponse<List<ProductModel>> baseResponse = await Future.delayed(
          Duration(seconds: 3),
          () async => await GetHomePageProductApi.callApi());
      products = baseResponse.data ?? [];
      loadingProducts(false);
      update();
    } on UnAuthorizedException catch (e) {
    } catch (e) {
    } finally {
      loadingProducts(false);
      update();
    }
  }

  UserModel userModel = getIt.get<UserModel>();
}
