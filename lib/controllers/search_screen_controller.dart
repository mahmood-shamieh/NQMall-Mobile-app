import 'package:app/data/search_products_api.dart';
import 'package:app/exceptions/unauthorized_exception.dart';
import 'package:app/exceptions/view_exception.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart' as BaseResponse;
import 'package:app/models/brand_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/product_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/utils/languages_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart';
import '../localization_service.dart';

class SearchScreenController extends GetxController {
  RxBool showFilterDialog = false.obs;
  RxBool filterCategories = true.obs;
  RxBool filterBrands = false.obs;
  RxBool loading = false.obs;
  UserModel userModel = getIt.get<UserModel>();
  ScrollController scrollController = ScrollController();
  List<CategoryModel> categories = getIt.get<List<CategoryModel>>();
  List<BrandModel> brands = getIt.get<List<BrandModel>>();
  Rx<List<CategoryModel>> selectedCategories = Rx([]);
  Rx<List<BrandModel>> selectedBrands = Rx([]);
  List<ProductModel> products = [];
  int page = 1;
  TextEditingController searchField = TextEditingController();
  @override
  void onInit() async {
    products.clear();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page += 1;
        loadSearchResult();
      }
    });
    loadSearchResult();
    super.onInit();
  }

  void addToSelectedCategories({required CategoryModel categoryModel}) {
    products.clear();
    page = 1;
    if (selectedCategories.value.contains(categoryModel)) {
      selectedCategories.value.remove(categoryModel);
    } else {
      selectedCategories.value.add(categoryModel);
    }
    update();
  }

  void addToSelectedBrands({required BrandModel brandModel}) {
    products.clear();
    page = 1;
    if (selectedBrands.value.contains(brandModel)) {
      selectedBrands.value.remove(brandModel);
    } else {
      selectedBrands.value.add(brandModel);
    }
    update();
  }

  void toggleFilterDialog() {
    showFilterDialog.value = !showFilterDialog.value;
    if (!showFilterDialog.value) {
      page = 1;
      products.clear();
      loadSearchResult();
    }

    update();
  }

  void toggleFilterView({
    required bool categories,
    required bool brands,
  }) {
    filterCategories.value = categories;
    filterBrands.value = brands;
    update();
  }

  Future loadSearchResult() async {
    try {
      loading(true);
      update();
      BaseResponse.BaseResponse<List<ProductModel>> baseResponse =
          await SearchProductsApi.callApi(
              page: page,
              limit: 10,
              categories: selectedCategories.value,
              brands: selectedBrands.value,
              searchQuery: searchField.text.trim());
      if (baseResponse.data!.isEmpty) {
        page -= 1;
      }
      products.addAll(baseResponse.data!);
    } on UnAuthorizedException catch (e) {
      Future.delayed(
          Durations.extralong1, () => Get.offAll(() => SigninScreen()));
    } catch (e) {
      if (e is ViewException) return;
      rethrow;
    } finally {
      loading(false);
      update();
    }
  }
}
