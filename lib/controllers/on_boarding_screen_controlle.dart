import 'package:get/get.dart';

class OnBoardingScreenController extends GetxController {
  RxInt currentPage = 0.obs;

  void moveToNext() {
    currentPage(currentPage.value + 1);
    update();
  }
}
