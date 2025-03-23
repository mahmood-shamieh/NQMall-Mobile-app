import 'package:app/components/style_widget.dart';
import 'package:app/controllers/on_boarding_screen_controlle.dart';
import 'package:app/screens/onBording/on_boarding_1_screen.dart';
import 'package:app/screens/onBording/on_boarding_2_screen.dart';
import 'package:app/screens/onBording/on_boarding_3_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          moveToNextAction: () => Get.to(() => StyleWidget()),
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
