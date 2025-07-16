import 'package:app/components/loading_component.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_text.dart';
import 'package:app/components/my_text_field.dart';
import 'package:app/components/style_widget.dart';
import 'package:app/controllers/sign_in_screen_controller.dart';
import 'package:app/screens/sign_Up_screen.dart';
import 'package:app/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInScreenController>(
      init: Get.put(SignInScreenController()),
      builder: (controller) => Scaffold(
        body: LoadingComponent(
          loading: controller.loading.value,
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
                      text: 'signinScreen.title'.tr,
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
                            text: 'signinScreen.usernameTitle'.tr,
                            fontWeight: FontWeight.w500,
                            size: MyTheme.labelTextSize,
                            color: MyTheme.labelColor,
                            margin: const EdgeInsets.only(
                              bottom: 6,
                            ),
                          ),
                          MyTextField(
                            hintText: 'signinScreen.usernameTitle'.tr,
                            controller: controller.username,
                            errorText: controller.usernameError.value,
                          ),
                          MyText(
                            text: 'signinScreen.password'.tr,
                            fontWeight: FontWeight.w500,
                            size: MyTheme.labelTextSize,
                            color: MyTheme.labelColor,
                            margin: const EdgeInsets.only(
                              bottom: 6,
                            ),
                          ),
                          MyTextField(
                            hintText: 'signinScreen.password'.tr,
                            controller: controller.password,
                            errorText: controller.passwordError.value,
                            obscureText: true,
                          ),
                          MyText(
                            text: 'signinScreen.forgetPassword'.tr,
                            fontWeight: FontWeight.w500,
                            size: 16,
                            color: MyTheme.textColorLight,
                            margin: const EdgeInsets.only(
                              bottom: 6,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          MyButton(
                            text: 'signinScreen.signinAction'.tr,
                            fontWeight: FontWeight.w700,
                            onPressed: () => controller.callSigninApi(),
                          ),
                          MyButton(
                            text: 'signinScreen.signupAction'.tr,
                            fontWeight: FontWeight.w700,
                            margin: const EdgeInsets.only(top: 16),
                            backgroundColor: MyTheme.secondaryColor,
                            onPressed: () => Get.offAll(() => SignUpScreen()),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
