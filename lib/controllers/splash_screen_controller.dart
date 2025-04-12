import 'package:app/components/style_widget.dart';
import 'package:app/data/sign_in_api.dart';
import 'package:app/exceptions/unauthorized_exception.dart';
import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart' as myBaseResponse;
import 'package:app/models/user_model.dart';
import 'package:app/screens/languages_screen%20.dart';
import 'package:app/screens/onBording/on_boarding_screen.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/utils/local_storage_keys.dart';
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
          checkLoginStatus(userModel);
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
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(OnBoardingScreen());
  }

  void moveToSigninScreen() async {
    await Future.delayed(const Duration(seconds: 2));
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
              passowrd: userModel.Password.toString());
      UserModel newUserModel = baseResponse.data!;
      newUserModel.Password = userModel.Password;
      getStorage.write(
          LocalStorageKeys.userModelKey.getKey(), newUserModel.toJson());
      if (getIt.isRegistered<UserModel>()) {
        getIt.unregister<UserModel>();
      }
      getIt.registerSingleton<UserModel>(newUserModel);
      Get.offAll(() => StyleWidget());
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
