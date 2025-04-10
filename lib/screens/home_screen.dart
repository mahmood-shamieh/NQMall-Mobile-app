import 'package:app/components/carousel_widget.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_text.dart';
import 'package:app/components/my_text_field.dart';
import 'package:app/controllers/home_page_controller.dart';
import 'package:app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      init: Get.put(HomePageController()),
      builder: (controller) => Scaffold(
        body: Stack(
          children: [
            Container(
              color: MyTheme.buttonColor,
              height: 350,
              width: double.infinity,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0)
                        .add(const EdgeInsets.only(top: 60)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.menu,
                          size: 40,
                          color: MyTheme.offWhiteColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          'assets/logo.svg',
                          color: MyTheme.offWhiteColor,
                          width: 100,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 40,
                          color: MyTheme.offWhiteColor,
                        ),
                        MyText(
                          text: controller.userModel.Address.toString(),
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsetsDirectional.only(
                              end: 8, bottom: 26),
                          decoration: BoxDecoration(
                            color: MyTheme.offWhiteColor,
                            borderRadius: BorderRadius.circular(
                              MyTheme.buttonsFontSize,
                            ),
                          ),
                          child: const Icon(
                            Icons.filter_alt_outlined,
                            size: 30,
                            color: MyTheme.buttonColor,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: MyTextField(
                            color: MyTheme.offWhiteColor,
                            hintText: 'homeScreen.searchFiled'.tr,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CarouselWidget(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: MyTheme.whiteColor,
                          borderRadius: BorderRadius.circular(
                            MyTheme.buttonsRadius,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: MyTheme.shadowColor,
                              offset: Offset(0, 1),
                              blurRadius: 1,
                              spreadRadius: 0.1,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const MyText(
                                text: "العنوان",
                                color: MyTheme.textColor,
                                size: MyTheme.textSizeXLarge,
                                fontWeight: FontWeight.w500,
                              ),
                              const MyText(
                                text: "وصف مبسط أو شرح عن العرض",
                                color: MyTheme.textColorLight,
                                size: MyTheme.textSizeSmall,
                              ),
                              MyButton(
                                  width: 120,
                                  height: 40,
                                  backgroundColor: MyTheme.thirdColor,
                                  margin: const EdgeInsets.only(top: 10),
                                  text: 'homeScreen.offerAction'.tr,
                                  fontWeight: FontWeight.w500,
                                  onPressed: () {})
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  MyText(
                    padding: EdgeInsets.all(8),
                    text: 'homeScreen.title1'.tr,
                    color: MyTheme.textColor,
                    size: MyTheme.textSizeXLarge,
                    fontWeight: FontWeight.bold,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: 20,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: MyTheme.shadowColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: MyText(text: index.toString()),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
