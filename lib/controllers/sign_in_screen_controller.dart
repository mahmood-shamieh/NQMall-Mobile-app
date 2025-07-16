import 'dart:io';

import 'package:app/components/dialog_box.dart';
import 'package:app/components/style_widget.dart';
import 'package:app/controllers/base_controller.dart';
import 'package:app/data/get_all_brand_api.dart';
import 'package:app/data/get_all_category_api.dart';
import 'package:app/data/get_cart_details_api.dart';
import 'package:app/data/sign_in_api.dart';
import 'package:app/exceptions/unauthorized_exception.dart';
import 'package:app/exceptions/view_exception.dart';
import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/brand_model.dart';
import 'package:app/models/cart_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/theme.dart';
import 'package:app/utils/languages_enum.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:app/utils/validate_app_availability.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';

import '../models/base_response.dart' as myBaseResponse;

class SignInScreenController extends BaseController {
  RxBool loading = false.obs;
  String currentLang = LocalizationService.getCurrentLocale().languageCode;
  Rx<String?> usernameError = null.obs;
  Rx<String?> passwordError = null.obs;
  TextEditingController username =
      TextEditingController(text: "john.doe@example.com");
  TextEditingController password = TextEditingController(text: "securePass123");

  @override
  void onInit() {
    // username.text = "mahmood@mahmood.mahmood";
    // password.text = "11111111";
    super.onInit();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return currentLang == Languages.arabic.code
          ? "الإيميل مطلوب"
          : 'Email is required';
    }

    // Simple email regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,40}$');
    if (!emailRegex.hasMatch(value)) {
      return currentLang == Languages.arabic.code
          ? "الإيميل غير صحيح"
          : 'Enter a valid email';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return currentLang == Languages.arabic.code
          ? "كلمة المرور مطلوبة"
          : 'Password is required';
    }

    if (value.length < 6) {
      return currentLang == Languages.arabic.code
          ? "كلمة المرور قصيرة"
          : 'Password must be at least 6 characters';
    }

    // Optional: check for a digit and a special character
    // final strongPassword = RegExp(r'^(?=.*[0-9])(?=.*[!@#\$&*~]).{6,}$');
    // if (!strongPassword.hasMatch(value)) {
    //   return 'Password must include a number and special character';
    // }

    return null;
  }

  callSigninApi() async {
    usernameError = (validateEmail(username.text.trim())).obs;
    passwordError = (validatePassword(password.text.trim())).obs;
    update();

    if (usernameError.value != null || passwordError.value != null) {
      return;
    }
    try {
      loading(true);
      BaseResponse<UserModel> baseResponse = await SigninApi.callApi(
          username: username.text, passowrd: password.text);
      UserModel userModel = baseResponse.data!;
      userModel.password = password.text.trim();
      GetStorage getStorage = getIt.get<GetStorage>();
      Map isAppAvailable = await ValidateAppAvailability.isAppAvailable(
          appConfigModel: userModel.appConfig!);
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
        Get.dialog(const DialogBox(
          title: "التطبيق غير مفعل",
          message: "يرجى التواصل مع الدعم للاستمرار في استخدام الخدمة",
          cancelText: "إغلاق",
        ));
        return;
      }
      getStorage.write(
          LocalStorageKeys.userModelKey.getKey(), userModel.toJson());
      if (getIt.isRegistered<UserModel>()) {
        getIt.unregister<UserModel>();
      }
      getIt.registerSingleton<UserModel>(userModel);
      await getCategories();
      await getBrands();
      await getCartDetails();
      Get.offAll(() => StyleWidget());
    } on UnAuthorizedException catch (e) {
      Get.dialog(
        DialogBox(
          title: 'unauthorizedDialog.title'.tr,
          message: e.message.toString(),
          cancelText: 'unauthorizedDialog.close'.tr,
        ),
      );
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
      // loading(true);
      // update();
      BaseResponse<List<CategoryModel>> baseResponse =
          await GetAllCategoriesApi.callApi();
      getIt.registerSingleton<List<CategoryModel>>(baseResponse.data!);
    } on UnAuthorizedException catch (e) {
      Future.delayed(
          Durations.extralong1, () => Get.offAll(() => SigninScreen()));
    } catch (e) {
      if (e is ViewException) return;
      rethrow;
    } finally {
      // loading(false);
      // update();
    }
  }

  Future getBrands() async {
    try {
      // loading(true);
      // update();
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
      // loading(false);
      // update();
    }
  }
}
