import 'package:app/components/my_button.dart';
import 'package:app/components/my_text.dart';
import 'package:app/components/my_text_field.dart';
import 'package:app/components/style_widget.dart';
import 'package:app/controllers/language_controller.dart';
import 'package:app/controllers/sign_in_screen_controller.dart';
import 'package:app/main.dart';
import 'package:app/screens/onBording/on_boarding_screen.dart';
import 'package:app/theme.dart';
import 'package:app/utils/languages_enum.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      init: Get.put(LanguageController()),
      builder: (controller) => Scaffold(
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
                    text: 'languagesScreen.title'.tr,
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
                    // color: Colors.amber,
                    height: MediaQuery.of(context).size.height - 300,
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            MyButton(
                              text: 'languagesScreen.arabic'.tr,
                              fontWeight: FontWeight.w700,
                              onPressed: () => controller.changeLanguages(
                                  lang: Languages.arabic),
                              margin: const EdgeInsets.only(bottom: 10),
                              backgroundColor:
                                  controller.currentLocale.value.languageCode ==
                                          Languages.arabic.code
                                      ? MyTheme.buttonColor
                                      : MyTheme.secondaryColor,
                              textColor:
                                  controller.currentLocale.value.languageCode ==
                                          Languages.arabic.code
                                      ? MyTheme.offWhiteColor
                                      : MyTheme.offWhiteColor,
                            ),
                            MyButton(
                              text: 'languagesScreen.english'.tr,
                              fontWeight: FontWeight.w700,
                              onPressed: () => controller.changeLanguages(
                                  lang: Languages.english),
                              margin: const EdgeInsets.only(bottom: 10),
                              backgroundColor:
                                  controller.currentLocale.value.languageCode ==
                                          Languages.english.code
                                      ? MyTheme.buttonColor
                                      : MyTheme.secondaryColor,
                              textColor:
                                  controller.currentLocale.value.languageCode ==
                                          Languages.english.code
                                      ? MyTheme.offWhiteColor
                                      : MyTheme.offWhiteColor,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            GetStorage getStorage = getIt.get<GetStorage>();
                            getStorage.write(
                                LocalStorageKeys.currentLanguages.key,
                                controller.currentLocale.value.languageCode);
                            Get.offAll(() => OnBoardingScreen());
                          },
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(
                                top: 80, bottom: 80),
                            width: 70,
                            height: 70,
                            child: Icon(
                              FontAwesomeIcons.arrowRight,
                              color: MyTheme.iconColor,
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyTheme.buttonColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
