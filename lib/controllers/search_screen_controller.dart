import 'package:app/main.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/utils/languages_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../localization_service.dart';

class SearchScreenController extends GetxController {
  UserModel userModel = getIt.get<UserModel>();
  CategoryModel? selectedCategoryModel;
  SearchScreenController({this.selectedCategoryModel});
  @override
  void onInit() {
    print("aaaaa");
    print(selectedCategoryModel);
    super.onInit();
  }
}
