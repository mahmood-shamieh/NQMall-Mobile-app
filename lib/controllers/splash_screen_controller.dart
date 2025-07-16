import 'dart:io';

import 'package:app/components/my_button.dart';
import 'package:app/components/style_widget.dart';
import 'package:app/data/get_all_brand_api.dart';
import 'package:app/data/get_all_category_api.dart';
import 'package:app/data/get_cart_details_api.dart';
import 'package:app/data/sign_in_api.dart';
import 'package:app/exceptions/unauthorized_exception.dart';
import 'package:app/exceptions/view_exception.dart';
import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart' as myBaseResponse;
import 'package:app/models/brand_model.dart';
import 'package:app/models/cart_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/languages_screen%20.dart';
import 'package:app/screens/onBording/on_boarding_screen.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/theme.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:app/utils/validate_app_availability.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import '../components/dialog_box.dart';

class SplashScreenController extends GetxController {
  RxBool loading = false.obs;
  @override
  void onInit() async {
    super.onInit();

    String? language = loadChooseLangPage();
    GetStorage getStorage = getIt.get<GetStorage>();
    UserModel? userModel = loadUserDetails();
    if (language == null &&
        getStorage.read(LocalStorageKeys.firstAppLunch.getKey()) == null) {
      moveToChooseLanguagesScreen();
      return;
    } else if (language != null) {
      LocalizationService.changeLocale(language);
      if (getStorage.read(LocalStorageKeys.firstAppLunch.getKey()) == null) {
        moveToOnBoarding();
      } else {
        if (userModel != null) {
          await getCategories();
          await getBrands();
          await checkLoginStatus(userModel);
        } else
          Future.delayed(
              Durations.extralong1, () => Get.offAll(() => SigninScreen()));
      }
      return;
    }
  }

  void moveToChooseLanguagesScreen() {
    Future.delayed(
        Durations.extralong1, () => Get.offAll(() => LanguagesScreen()));
  }

  void moveToOnBoarding() async {
    await Future.delayed(const Duration(seconds: 0));
    Get.offAll(OnBoardingScreen());
  }

  void moveToSigninScreen() async {
    await Future.delayed(const Duration(seconds: 0));
    Get.offAll(SigninScreen());
  }

  UserModel? loadUserDetails() {
    GetStorage getStorage = getIt.get<GetStorage>();
    String? userString =
        getStorage.read(LocalStorageKeys.userModelKey.getKey());
    if (userString != null) {
      return UserModel.fromJson(userString);
    } else {
      return null;
    }
  }

  String? loadChooseLangPage() {
    GetStorage getStorage = getIt.get<GetStorage>();
    String? lang = getStorage.read(LocalStorageKeys.currentLanguages.getKey());
    return lang;
  }

  Future checkLoginStatus(UserModel userModel) async {
    GetStorage getStorage = getIt.get<GetStorage>();
    try {
      loading(true);
      myBaseResponse.BaseResponse<UserModel> baseResponse =
          await SigninApi.callApi(
              username: userModel.Email.toString(),
              passowrd: userModel.password.toString());
      UserModel newUserModel = baseResponse.data!;
      newUserModel.password = userModel.password;
      Map isAppAvailable = await ValidateAppAvailability.isAppAvailable(
          appConfigModel: newUserModel.appConfig!);
      if (!isAppAvailable['WorkingOrNot']) {
        Get.dialog(DialogBox(
          title: "تحديث التطبيق",
          message:
              "يرجى تحديث التطبيق إلى أحدث إصدار للاستمرار في استخدام الخدمة",
          cancelText: "إغلاق",
          onCancel: () => exit(0),
        ));
        return;
      } else if (!isAppAvailable['AppEnabled']) {
        Get.dialog(DialogBox(
          title: "التطبيق غير مفعل",
          message: "يرجى التواصل مع الدعم للاستمرار في استخدام الخدمة",
          cancelText: "إغلاق",
        ));
        return;
      }
      getStorage.write(
          LocalStorageKeys.userModelKey.getKey(), newUserModel.toJson());
      if (getIt.isRegistered<UserModel>()) {
        getIt.unregister<UserModel>();
      }
      getIt.registerSingleton<UserModel>(newUserModel);
      await getCartDetails();
      Get.offAll(() => StyleWidget());
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

  Future getCartDetails() async {
    GetStorage getStorage = getIt.get<GetStorage>();
    try {
      loading(true);
      myBaseResponse.BaseResponse<CartModel> baseResponse =
          await GetCartDetailsApi.callApi(userModel: getIt.get<UserModel>());
      CartModel cartModel = baseResponse.data!;

      getIt.registerSingleton<CartModel>(cartModel);
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

  Future getCategories() async {
    try {
      loading(true);
      update();
      myBaseResponse.BaseResponse<List<CategoryModel>> baseResponse =
          await GetAllCategoriesApi.callApi();
      getIt.registerSingleton<List<CategoryModel>>(baseResponse.data!);
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

  Future getBrands() async {
    try {
      loading(true);
      update();
      myBaseResponse.BaseResponse<List<BrandModel>> baseResponse =
          await GetAllBrandApi.callApi();
      getIt.registerSingleton<List<BrandModel>>(baseResponse.data!);
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
}
