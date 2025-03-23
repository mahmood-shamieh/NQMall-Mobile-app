import 'package:app/controllers/splash_screen_controller.dart';
import 'package:app/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
        init: Get.put(SplashScreenController()),
        builder: (controller) {
          return Scaffold(
            body: Center(
              child: Container(
                child: Center(
                  child: SvgPicture.asset(
                    'assets/logo.svg',
                  ),
                ),
                decoration: BoxDecoration(
                  color: MyTheme.textColor,
                ),
              ),
            ),
          );
        });
  }
}
