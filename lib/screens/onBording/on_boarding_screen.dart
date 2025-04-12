import 'package:app/components/style_widget.dart';
import 'package:app/controllers/on_boarding_screen_controlle.dart';
import 'package:app/main.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/onBording/on_boarding_1_screen.dart';
import 'package:app/screens/onBording/on_boarding_2_screen.dart';
import 'package:app/screens/onBording/on_boarding_3_screen.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  Widget getCurrentOnBoardingPage(OnBoardingScreenController controller) {
    switch (controller.currentPage.value) {
      case 0:
        return OnBoarding1Screen(
          moveToNextAction: () => controller.moveToNext(),
        );
      case 1:
        return OnBoarding2Screen(
          moveToNextAction: () => controller.moveToNext(),
        );
      case 2:
        return OnBoarding3Screen(
          moveToNextAction: () {
            GetStorage getStorage = getIt.get<GetStorage>();
            getStorage.write(LocalStorageKeys.firstAppLunch.getKey(), 'done');
            String? userString =
                getStorage.read(LocalStorageKeys.userModelKey.getKey());
            if (userString != null) {
              UserModel userModel = UserModel.fromJson(userString);
              if (getIt.isRegistered<UserModel>()) {
                getIt.unregister<UserModel>();
              }
              getIt.registerSingleton(userModel);
              Get.offAll(() => StyleWidget());
            } else {
              Get.offAll(() => SigninScreen());
            }
          },
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingScreenController>(
      init: Get.put(OnBoardingScreenController()),
      builder: (controller) => Scaffold(
        body: getCurrentOnBoardingPage(controller),
      ),
    );
  }
}
