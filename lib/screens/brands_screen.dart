import 'package:app/components/brand_widget.dart';
import 'package:app/components/loading_widget.dart';
import 'package:app/controllers/brands_screen_controller.dart';
import 'package:app/controllers/search_screen_controller.dart';
import 'package:app/enums/loading_type.dart';
import 'package:app/main.dart';
import 'package:app/models/brand_model.dart';
import 'package:app/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../components/my_text.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandsScreenController>(
      init: BrandsScreenController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: MyTheme.buttonColor,
            centerTitle: true,
            title: MyText(
              text: "brandScreen.title".tr,
              fontWeight: FontWeight.bold,
              size: MyTheme.textSizeXLarge,
              color: MyTheme.offWhiteColor,
            ),
          ),
          body: controller.loading.value
              ? const Center(
                  child: LoadingWidget(
                  loadingType: LoadingType.bar,
                ))
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 12, left: 8, right: 8),
                        width: double.infinity,
                        child: (controller.brands ?? []).isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...controller.brands.map(
                                    (e) => BrandWidget(
                                      isSelected:
                                          controller.isSelected(brandModel: e),
                                      brandModel: e,
                                      showDescription: true,
                                      onTap: () {
                                        late SearchScreenController
                                            screenController;
                                        try {
                                          screenController = Get.find<
                                              SearchScreenController>();
                                        } catch (e) {
                                          screenController =
                                              Get.put<SearchScreenController>(
                                                  SearchScreenController());
                                        }
                                        screenController.selectedBrands.value
                                            .clear();
                                        screenController.addToSelectedBrands(
                                            brandModel: e);
                                        getIt
                                            .get<PersistentTabController>()
                                            .jumpToTab(2);
                                        screenController.loadSearchResult();
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  )
                                ],
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.business_outlined,
                                      size: 80,
                                      color: MyTheme.secondaryColor,
                                    ),
                                    const SizedBox(height: 16),
                                    MyText(
                                      text: "empty".tr,
                                      color: MyTheme.textColor,
                                      size: MyTheme.textSizeLarge,
                                    ),
                                  ],
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
