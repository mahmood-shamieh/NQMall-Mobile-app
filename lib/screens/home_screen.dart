import 'package:app/components/carousel_widget.dart';
import 'package:app/components/category_widget.dart';
import 'package:app/components/loading_widget.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_text.dart';
import 'package:app/components/my_text_field.dart';
import 'package:app/components/product_widget.dart';
import 'package:app/controllers/home_screen_controller.dart';
import 'package:app/controllers/search_screen_controller.dart';
import 'package:app/enums/loading_type.dart';
import 'package:app/main.dart';
import 'package:app/screens/product_details_screen.dart';
import 'package:app/screens/search_screen.dart';
import 'package:app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: Get.put(HomeScreenController()),
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
                            end: 8,
                          ),
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
                          child: InkWell(
                            onTap: () => Get.to(
                              () => SearchScreen(),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MyTheme.buttonsRadius),
                                color: MyTheme.offWhiteColor,
                              ),
                              child: MyText(
                                text: 'homeScreen.searchFiled'.tr,
                                color: MyTheme.secondaryColor,
                              ),
                            ),
                          ),
                        ),
                        // MyTextField(
                        //     color: MyTheme.offWhiteColor,
                        //     hintText: 'homeScreen.searchFiled'.tr,
                        //   )
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
                  controller.loadingCategories.value
                      ? const SizedBox(
                          height: 200,
                          child: Center(
                            child: LoadingWidget(
                              loadingType: LoadingType.circle,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            itemCount: controller.categories.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.75,
                            ),
                            itemBuilder: (context, index) {
                              return CategoryWidget(
                                action: () {
                                  late SearchScreenController screenController;
                                  try {
                                    screenController =
                                        Get.find<SearchScreenController>();
                                  } catch (e) {
                                    screenController =
                                        Get.put<SearchScreenController>(
                                            SearchScreenController());
                                  }
                                  screenController.addToSelectedCategories(
                                      categoryModel:
                                          controller.categories[index]);
                                  getIt
                                      .get<PersistentTabController>()
                                      .jumpToTab(2);
                                },
                                categoryModel: controller.categories[index],
                              );
                            },
                          ),
                        ),
                  MyText(
                    padding: EdgeInsets.all(8),
                    text: 'homeScreen.title2'.tr,
                    color: MyTheme.textColor,
                    size: MyTheme.textSizeXLarge,
                    fontWeight: FontWeight.bold,
                  ),
                  controller.loadingProducts.value
                      ? const SizedBox(
                          height: 200,
                          child: Center(
                            child: LoadingWidget(
                              loadingType: LoadingType.circle,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            itemCount: controller.products.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.75,
                            ),
                            itemBuilder: (context, index) {
                              return ProductWidget(
                                action: () => Get.to(
                                  () => ProductDetailsScreen(
                                    productModel: controller.products[index],
                                  ),
                                ),
                                productModel: controller.products[index],
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
