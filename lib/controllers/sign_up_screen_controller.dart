import 'package:app/components/dialog_box.dart';
import 'package:app/components/style_widget.dart';
import 'package:app/data/get_all_brand_api.dart';
import 'package:app/data/get_all_category_api.dart';
import 'package:app/data/get_cart_details_api.dart';
import 'package:app/data/sign_up_api.dart';
import 'package:app/exceptions/unauthorized_exception.dart';
import 'package:app/exceptions/view_exception.dart';
import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/base_response.dart' as myBaseResponse;
import 'package:app/models/brand_model.dart';
import 'package:app/models/cart_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignUpScreenController extends GetxController {
  RxBool loading = false.obs;
  TextEditingController email = TextEditingController(text: 'test@test.test');
  TextEditingController fullName = TextEditingController(text: 'Test');
  TextEditingController phone = TextEditingController(text: '0966503636');
  TextEditingController address =
      TextEditingController(text: 'Damascu Kafer Batna');
  TextEditingController password = TextEditingController(text: '11111111');
  TextEditingController confirmPassword =
      TextEditingController(text: '11111111');

  Rx<String?> emailError = null.obs;
  Rx<String?> fullnameError = null.obs;
  Rx<String?> phoneError = null.obs;
  Rx<String?> addressError = null.obs;
  Rx<String?> passwordError = null.obs;
  Rx<String?> confirmPasswordError = null.obs;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocalizationService.getCurrentLocale().languageCode == 'ar'
          ? 'الإيميل مطلوب'
          : 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return LocalizationService.getCurrentLocale().languageCode == 'ar'
          ? 'الإيميل غير صالح'
          : 'Enter a valid email';
    }
    return null;
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return LocalizationService.getCurrentLocale().languageCode == 'ar'
          ? 'الاسم الكامل مطلوب'
          : 'Full name is required';
    }

    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return LocalizationService.getCurrentLocale().languageCode == 'ar'
          ? 'رقم الموبايل مطلوب'
          : 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?\d{7,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return LocalizationService.getCurrentLocale().languageCode == 'ar'
          ? 'رقم الموبايل غير صحيح'
          : 'Enter a valid phone number';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return LocalizationService.getCurrentLocale().languageCode == 'ar'
          ? 'العنوان مطلوب'
          : 'Address is required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocalizationService.getCurrentLocale().languageCode == 'ar'
          ? 'كلمة المرور مطلوبة'
          : 'Password is required';
    }
    if (value.length < 6) {
      return LocalizationService.getCurrentLocale().languageCode == 'ar'
          ? 'كلمة المرور قصيرة'
          : 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String passwordValue) {
    if (value == null || value.isEmpty) {
      return LocalizationService.getCurrentLocale().languageCode == 'ar'
          ? 'تأكية كلمة المرور مطلوب'
          : 'Confirm password is required';
    }
    if (value != passwordValue) {
      return LocalizationService.getCurrentLocale().languageCode == 'ar'
          ? 'كلمتا المرور غير متطابقتان'
          : 'Passwords do not match';
    }
    return null;
  }

  signupAction() async {
    emailError = (validateEmail(email.text.trim())).obs;
    fullnameError = (validateFullName(fullName.text.trim())).obs;
    phoneError = (validatePhone(phone.text.trim())).obs;
    addressError = (validateAddress(address.text.trim())).obs;
    passwordError = (validatePassword(password.text.trim())).obs;
    confirmPasswordError =
        (validateConfirmPassword(confirmPassword.text, password.text.trim()))
            .obs;
    update();
    if (emailError.value != null ||
        fullnameError.value != null ||
        phoneError.value != null ||
        addressError.value != null ||
        passwordError.value != null ||
        confirmPasswordError.value != null) {
      return;
    }
    try {
      loading(true);
      BaseResponse<UserModel> baseResponse = await await SignupApi.callApi(
        userModel: UserModel(
          Email: email.text.trim(),
          FullName: fullName.text.trim(),
          PhoneNumber: phone.text.trim(),
          Address: address.text.trim(),
          PasswordHash: password.text.trim(),
        ),
      );
      UserModel userModel = baseResponse.data!;
      GetStorage getStorage = getIt.get<GetStorage>();
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
    } on ViewException catch (e) {
      Get.dialog(
        DialogBox(
          title: 'ViewErrorDialog.title'.tr,
          message: e.message.toString(),
          cancelText: 'ViewErrorDialog.close'.tr,
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
