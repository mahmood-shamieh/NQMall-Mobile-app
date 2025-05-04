import 'package:app/components/image_attribute_scroll_widget.dart';
import 'package:app/components/loading_widget.dart';
import 'package:app/components/my_text.dart';
import 'package:app/components/text_attribute_scroll_widget.dart';
import 'package:app/controllers/product_details_screen_controller.dart';
import 'package:app/enums/loading_type.dart';
import 'package:app/localization_service.dart';
import 'package:app/models/product_model.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/theme.dart';
import 'package:app/utils/convert_to_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init:
            Get.put(ProductDetailsScreenController(productModel: productModel)),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyTheme.buttonColor,
              centerTitle: true,
              title: MyText(
                text: "ProductDetailsScreen.title".tr,
                fontWeight: FontWeight.bold,
                size: MyTheme.textSizeXLarge,
              ),
              leading: InkWell(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: MyTheme.iconColor,
                  size: 30,
                ),
              ),
            ),
            body: controller.loading.value
                ? const Center(
                    child: LoadingWidget(
                    loadingType: LoadingType.bar,
                  ))
                : Container(
                    padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: LocalizationService.getCurrentLocale()
                                      .languageCode ==
                                  "ar"
                              ? controller.productModel.NameAr.toString()
                              : controller.productModel.NameEn.toString(),
                          color: MyTheme.textColor,
                          fontWeight: FontWeight.w700,
                          size: MyTheme.textSizeLarge,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(4),
                              width: ((MediaQuery.of(context).size.width / 3) *
                                      2) -
                                  16,
                              height: ((MediaQuery.of(context).size.width / 3) *
                                      2) -
                                  16,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  MyTheme.buttonsRadius,
                                ),
                                border: Border.all(
                                  color: MyTheme.borderColor,
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "${NetworkURLs.getMediaServer()}${controller.selectedMedia != null ? controller.selectedMedia?.value.URL?.convertToUrl() : controller.productModel.media?[0].URL?.convertToUrl()}",
                                  ),
                                ),
                                color: MyTheme.buttonColor,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  MyTheme.buttonsRadius,
                                ),
                              ),
                              height: ((MediaQuery.of(context).size.width / 3) *
                                      2) -
                                  16,
                              width:
                                  (MediaQuery.of(context).size.width / 3) - 16,
                              child: Stack(
                                children: [
                                  ListView(
                                    scrollDirection: Axis.vertical,
                                    children: (controller.productModel.media ??
                                            [])
                                        .map(
                                          (e) => InkWell(
                                            onTap: () => controller
                                                .setSelectedMediaToPreview(
                                                    mediaModel: e),
                                            child: Container(
                                              margin: const EdgeInsets.all(4),
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3) -
                                                  16,
                                              height: (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3) -
                                                  16,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  MyTheme.buttonsRadius,
                                                ),
                                                border: Border.all(
                                                  color: controller
                                                              .selectedMedia
                                                              ?.value
                                                              .Id ==
                                                          e.Id
                                                      ? MyTheme.buttonColor
                                                      : MyTheme.borderColor,
                                                  width: 2,
                                                ),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    "${NetworkURLs.getMediaServer()}${e.URL?.convertToUrl()}",
                                                  ),
                                                ),
                                                color: MyTheme.buttonColor,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(
                                              MyTheme.buttonsRadius),
                                          topRight: Radius.circular(
                                              MyTheme.buttonsRadius),
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.1),
                                            Colors.transparent
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 15,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                              MyTheme.buttonsRadius),
                                          bottomRight: Radius.circular(
                                              MyTheme.buttonsRadius),
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.1)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        ...(controller.productModel.attributes ?? [])
                            .map(
                              (e) => (e.Type == "list" || e.Type == "items")
                                  ? TextAttributeScrollWidget(
                                      action: controller
                                          .addValueToSelectedAttributesValues,
                                      attributeModel: e,
                                      selectedValue:
                                          controller.selectedValues.value[e],
                                    )
                                  : ImageAttributeScrollWidget(
                                      action: controller
                                          .addValueToSelectedAttributesValues,
                                      attributeModel: e,
                                      selectedValue:
                                          controller.selectedValues.value[e],
                                    ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
          );
        });
  }
}
