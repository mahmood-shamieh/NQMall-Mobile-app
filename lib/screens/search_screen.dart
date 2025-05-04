import 'package:app/components/carousel_widget.dart';
import 'package:app/components/category_widget.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_text.dart';
import 'package:app/components/my_text_field.dart';
import 'package:app/components/popular_search_widget.dart';
import 'package:app/controllers/home_screen_controller.dart';
import 'package:app/controllers/search_screen_controller.dart';
import 'package:app/models/category_model.dart';
import 'package:app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      init: Get.put(SearchScreenController()),
      builder: (controller) {
        return Scaffold(
          backgroundColor: MyTheme.offWhiteColor,
          body: Stack(
            children: [
              Container(
                color: MyTheme.buttonColor,
                height: 140,
                width: double.infinity,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            child: const Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 8),
                              child: Icon(
                                FontAwesomeIcons.arrowRight,
                                color: MyTheme.offWhiteColor,
                                size: 30,
                              ),
                            ),
                          ),
                          MyText(
                            text: "searchPage.title".tr.capitalize.toString(),
                            textAlign: TextAlign.center,
                            size: MyTheme.textSizeXLarge,
                            fontWeight: FontWeight.w500,
                            color: MyTheme.offWhiteColor,
                          ),
                          const SizedBox(
                            width: 46,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0)
                            .add(const EdgeInsets.only(top: 16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsetsDirectional.only(
                                  end: 8, bottom: 0),
                              decoration: BoxDecoration(
                                color: MyTheme.offWhiteColor,
                                border: Border.all(
                                    color: MyTheme.borderColor, width: 2),
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
                                hintText: 'searchPage.searchFiled'.tr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   decoration: const BoxDecoration(
                      //     color: MyTheme.offWhiteColor,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: MyTheme.borderColor,
                      //         offset: Offset(0, 10),
                      //         blurRadius: 10,
                      //         spreadRadius: 1,
                      //       ),
                      //     ],
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         MyText(
                      //           text:
                      //               "${'searchPage.popularSearchAreTitle'.tr}:",
                      //           color: MyTheme.textColor,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //         const SizedBox(
                      //           height: 8,
                      //         ),
                      //         Wrap(
                      //           alignment: WrapAlignment.start,
                      //           children:
                      //               ["RICE", "VEGETABLES", "BISCUITS", "BREAD"]
                      //                   .map((e) => PopularSearchWidget(
                      //                         text: e,
                      //                       ))
                      //                   .toList(),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           MyText(
                      //             padding: const EdgeInsets.only(bottom: 8),
                      //             text: "${'searchPage.trendingAreTitle'.tr}:",
                      //             color: MyTheme.textColor,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ],
                      //       ),
                      //       GridView.builder(
                      //         itemCount: 20,
                      //         physics: const NeverScrollableScrollPhysics(),
                      //         shrinkWrap: true,
                      //         padding: const EdgeInsets.all(0),
                      //         gridDelegate:
                      //             SliverGridDelegateWithFixedCrossAxisCount(
                      //           crossAxisCount: 3,
                      //           crossAxisSpacing: 10.0,
                      //           mainAxisSpacing: 10.0,
                      //           childAspectRatio: 0.75,
                      //         ),
                      //         itemBuilder: (context, index) {
                      //           return CategoryWidget(
                      //             categoryModel: CategoryModel(),
                      //           );
                      //         },
                      //       )
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
