import 'package:app/components/brand_filter_widget.dart';
import 'package:app/components/cactegory_filter_widget.dart';
import 'package:app/components/carousel_widget.dart';
import 'package:app/components/category_widget.dart';
import 'package:app/components/loading_widget.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_text.dart';
import 'package:app/components/my_text_field.dart';
import 'package:app/components/popular_search_widget.dart';
import 'package:app/components/product_widget.dart';
import 'package:app/controllers/home_screen_controller.dart';
import 'package:app/controllers/search_screen_controller.dart';
import 'package:app/enums/loading_type.dart';
import 'package:app/models/category_model.dart';
import 'package:app/screens/product_details_screen.dart';
import 'package:app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: const Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(horizontal: 8),
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
                    Container(
                      padding: const EdgeInsets.all(8.0)
                          .add(const EdgeInsets.only(top: 16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => controller.toggleFilterDialog(),
                            child: Stack(
                              clipBehavior: Clip.none,
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
                                Visibility(
                                  visible:
                                      controller.selectedBrands.value.length +
                                              controller.selectedCategories
                                                  .value.length >
                                          0,
                                  child: Positioned(
                                    top: -20,
                                    right: -10,
                                    child: Transform.scale(
                                      scale: 0.5,
                                      child: CircleAvatar(
                                        backgroundColor: MyTheme.warnColor,
                                        child: Container(
                                          margin: const EdgeInsets.all(4),
                                          child: Center(
                                            child: MyText(
                                              text: (controller.selectedBrands
                                                          .value.length +
                                                      controller
                                                          .selectedCategories
                                                          .value
                                                          .length)
                                                  .toString(),
                                              color: MyTheme.offWhiteColor,
                                              size: MyTheme.textSizeXSmall,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 55,
                              child: MyTextField(
                                controller: controller.searchField,
                                color: MyTheme.offWhiteColor,
                                hintText: 'searchPage.searchFiled'.tr,
                                suffixIcon: Icons.search,
                                onSuffixTap: () {
                                  controller.loadSearchResult();
                                  controller.products.clear();
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 180),
                child: GridView.builder(
                  itemCount: controller.products.length,
                  controller: controller.scrollController,
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.74,
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
              ),
              Visibility(
                visible: controller.showFilterDialog.value,
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 150,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: MyTheme.offWhiteColor,
                      boxShadow: const [
                        BoxShadow(
                          color: MyTheme.shadowColor,
                          offset: Offset(0, 0),
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ],
                      borderRadius: BorderRadius.circular(
                        MyTheme.buttonsRadius,
                      ),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(MyTheme.buttonsRadius),
                            topRight: Radius.circular(MyTheme.buttonsRadius),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => controller.toggleFilterView(
                                      categories: true, brands: false),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                        color: controller.filterCategories.value
                                            ? MyTheme.buttonColor
                                            : MyTheme.secondaryColor),
                                    child: MyText(
                                      text: 'searchScreen.categories'.tr,
                                      color: MyTheme.offWhiteColor,
                                      textAlign: TextAlign.center,
                                      fontWeight:
                                          controller.filterCategories.value
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => controller.toggleFilterView(
                                      categories: false, brands: true),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    color: controller.filterBrands.value
                                        ? MyTheme.buttonColor
                                        : MyTheme.secondaryColor,
                                    child: MyText(
                                        text: 'searchScreen.brands'.tr,
                                        color: MyTheme.offWhiteColor,
                                        textAlign: TextAlign.center,
                                        fontWeight:
                                            controller.filterBrands.value
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: MyButton(
                              height: 40,
                              width: 100,
                              text: 'searchScreen.close'.tr,
                              onPressed: () => controller.toggleFilterDialog(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 50),
                          child: SingleChildScrollView(
                            controller: controller.scrollController,
                            child: Column(
                              children: controller.filterBrands.value
                                  ? controller.brands
                                      .map(
                                        (e) => BrandFilterWidget(
                                          action: () =>
                                              controller.addToSelectedBrands(
                                                  brandModel: e),
                                          brandModel: e,
                                          selected: controller
                                              .selectedBrands.value
                                              .contains(e),
                                        ),
                                      )
                                      .toList()
                                  : controller.categories
                                      .map(
                                        (e) => CategoryFilterWidget(
                                          action: () => controller
                                              .addToSelectedCategories(
                                                  categoryModel: e),
                                          categoryModel: e,
                                          selected: controller
                                              .selectedCategories.value
                                              .contains(e),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: controller.loading.value,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: MyTheme.shadowColor.withOpacity(0.7),
                  child: const Center(
                    child: LoadingWidget(
                      loadingType: LoadingType.bar,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
