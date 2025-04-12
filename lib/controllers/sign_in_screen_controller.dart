import 'package:app/components/dialog_box.dart';
import 'package:app/components/style_widget.dart';
import 'package:app/controllers/base_controller.dart';
import 'package:app/data/sign_in_api.dart';
import 'package:app/exceptions/unauthorized_exception.dart';
import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/user_model.dart';
import 'package:app/theme.dart';
import 'package:app/utils/languages_enum.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';

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
      BaseResponse<UserModel> baseResponse = await Future.delayed(
          Duration(seconds: 3),
          () async => await SigninApi.callApi(
              username: username.text, passowrd: password.text));
      UserModel userModel = baseResponse.data!;
      userModel.Password = password.text.trim();
      GetStorage getStorage = getIt.get<GetStorage>();
      getStorage.write(
          LocalStorageKeys.userModelKey.getKey(), userModel.toJson());
      if (getIt.isRegistered<UserModel>()) {
        getIt.unregister<UserModel>();
      }
      getIt.registerSingleton<UserModel>(userModel);
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
    } finally {
      loading(false);
      update();
    }
  }
}
