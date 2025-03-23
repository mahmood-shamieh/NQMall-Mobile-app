import 'package:app/screens/onBording/on_boarding_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    moveToOnBoarding();
    super.onInit();
  }

  void moveToOnBoarding() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(OnBoardingScreen());
  }
}
