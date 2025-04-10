import 'package:app/components/loading_component.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_text.dart';
import 'package:app/components/my_text_field.dart';
import 'package:app/components/style_widget.dart';
import 'package:app/controllers/sign_up_screen_controller.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpScreenController>(
      init: Get.put(SignUpScreenController()),
      builder: (controller) => LoadingComponent(
          body: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 20),
                        child: SvgPicture.asset('assets/dark logo.svg'),
                      ),
                      MyText(
                        text: 'signupScreen.title'.tr,
                        fontWeight: FontWeight.bold,
                        size: MyTheme.textSizeXLarge,
                        color: MyTheme.textColor,
                        margin: const EdgeInsets.only(
                          bottom: 6,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: 'signupScreen.usernameTitle'.tr,
                              fontWeight: FontWeight.w500,
                              size: MyTheme.labelTextSize,
                              color: MyTheme.labelColor,
                              margin: const EdgeInsets.only(
                                bottom: 6,
                              ),
                            ),
                            MyTextField(
                              hintText: 'signupScreen.usernameTitle'.tr,
                              controller: controller.email,
                              errorText: controller.emailError.value,
                            ),
                            MyText(
                              text: 'signupScreen.fullName'.tr,
                              fontWeight: FontWeight.w500,
                              size: MyTheme.labelTextSize,
                              color: MyTheme.labelColor,
                              margin: const EdgeInsets.only(
                                bottom: 6,
                              ),
                            ),
                            MyTextField(
                              hintText: 'signupScreen.fullName'.tr,
                              controller: controller.fullName,
                              errorText: controller.fullnameError.value,
                            ),
                            MyText(
                              text: 'signupScreen.phoneNumber'.tr,
                              fontWeight: FontWeight.w500,
                              size: MyTheme.labelTextSize,
                              color: MyTheme.labelColor,
                              margin: const EdgeInsets.only(
                                bottom: 6,
                              ),
                            ),
                            MyTextField(
                              hintText: 'signupScreen.phoneNumber'.tr,
                              controller: controller.phone,
                              keyboardType: TextInputType.phone,
                              errorText: controller.phoneError.value,
                            ),
                            MyText(
                              text: 'signupScreen.address'.tr,
                              fontWeight: FontWeight.w500,
                              size: MyTheme.labelTextSize,
                              color: MyTheme.labelColor,
                              margin: const EdgeInsets.only(
                                bottom: 6,
                              ),
                            ),
                            MyTextField(
                              hintText: 'signupScreen.address'.tr,
                              controller: controller.address,
                              errorText: controller.addressError.value,
                            ),
                            MyText(
                              text: 'signupScreen.password'.tr,
                              fontWeight: FontWeight.w500,
                              size: MyTheme.labelTextSize,
                              color: MyTheme.labelColor,
                              margin: const EdgeInsets.only(
                                bottom: 6,
                              ),
                            ),
                            MyTextField(
                              hintText: 'signupScreen.password'.tr,
                              controller: controller.password,
                              errorText: controller.passwordError.value,
                            ),
                            MyText(
                              text: 'signupScreen.confirmPassword'.tr,
                              fontWeight: FontWeight.w500,
                              size: MyTheme.labelTextSize,
                              color: MyTheme.labelColor,
                              margin: const EdgeInsets.only(
                                bottom: 6,
                              ),
                            ),
                            MyTextField(
                              hintText: 'signupScreen.confirmPassword'.tr,
                              controller: controller.confirmPassword,
                              errorText: controller.confirmPasswordError.value,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            MyButton(
                              text: 'signupScreen.signupAction'.tr,
                              fontWeight: FontWeight.w700,
                              onPressed: () => controller.signupAction(),
                            ),
                            MyButton(
                              margin: const EdgeInsets.only(top: 16),
                              backgroundColor: MyTheme.secondaryColor,
                              text: 'signupScreen.signinAction'.tr,
                              fontWeight: FontWeight.w700,
                              onPressed: () => Get.offAll(() => SigninScreen()),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          loading: controller.loading.value),
    );
  }
}
