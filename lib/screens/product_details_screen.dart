import 'package:app/components/image_attribute_scroll_widget.dart';
import 'package:app/components/loading_widget.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_text.dart';
import 'package:app/components/text_attribute_scroll_widget.dart';
import 'package:app/controllers/product_details_screen_controller.dart';
import 'package:app/enums/loading_type.dart';
import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/models/cart_model.dart';
import 'package:app/models/product_model.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/theme.dart';
import 'package:app/utils/convert_to_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text:
                              "${controller.productModel.Id}-${LocalizationService.getCurrentLocale().languageCode == "ar" ? controller.productModel.NameAr.toString() : controller.productModel.NameEn.toString()}",
                          color: MyTheme.textColor,
                          fontWeight: FontWeight.w700,
                          size: MyTheme.textSizeXLarge,
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
                                  image: CachedNetworkImageProvider(
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
                                                  image:
                                                      CachedNetworkImageProvider(
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
                          height: 6,
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
                        const SizedBox(
                          height: 8,
                        ),
                        MyText(
                          text:
                              "${"ProductDetailsScreen.descriptionTitle".tr}:",
                          color: MyTheme.textColor,
                          fontWeight: FontWeight.w500,
                          size: MyTheme.textSizeLarge,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 6),
                          child: LocalizationService.getCurrentLocale()
                                      .languageCode ==
                                  "ar"
                              ? MyText(
                                  text: controller.productModel.DescriptionAr
                                      .toString(),
                                  color: MyTheme.textColor,
                                  fontWeight: FontWeight.normal,
                                  size: MyTheme.textSizeSmall,
                                )
                              : MyText(
                                  text: controller.productModel.DescriptionEn
                                      .toString(),
                                  color: MyTheme.textColor,
                                  fontWeight: FontWeight.normal,
                                  size: MyTheme.textSizeSmall,
                                ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        MyText(
                          text: "${"ProductDetailsScreen.detailsTile".tr}:",
                          color: MyTheme.textColor,
                          fontWeight: FontWeight.w500,
                          size: MyTheme.textSizeLarge,
                        ),
                        ...LocalizationService.getCurrentLocale()
                                    .languageCode ==
                                "ar"
                            ? controller.productModel.DetailsAr!.entries
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 6),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: MyText(
                                            text: "${e.key}:",
                                            color: MyTheme.textColor,
                                            size: MyTheme.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 9,
                                        ),
                                        Flexible(
                                          child: MyText(
                                            text: e.value,
                                            color: MyTheme.textColor,
                                            size: MyTheme.textSizeXSmall,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList()
                            : controller.productModel.DetailsEn!.entries
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 6),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: MyText(
                                            text: "${e.key}:",
                                            color: MyTheme.textColor,
                                            size: MyTheme.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 9,
                                        ),
                                        Flexible(
                                          child: MyText(
                                            text: e.value,
                                            color: MyTheme.textColor,
                                            size: MyTheme.textSizeXSmall,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                        const SizedBox(
                          height: 220,
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedScale(
                  scale: controller.matchedVariation.value != null ? 1 : 0,
                  alignment: Alignment.bottomCenter,
                  duration: Durations.medium2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: MyTheme.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: MyTheme.shadowColor,
                            spreadRadius: 1,
                            blurRadius: 50,
                            offset: Offset(0, -10),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(MyTheme.buttonsRadius),
                          topRight: Radius.circular(MyTheme.buttonsRadius),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0)
                            .add(const EdgeInsets.only(bottom: 16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () =>
                                      controller.resetPurchaseProcess(),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: MyTheme.warnColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      size: 30,
                                      color: MyTheme.whiteColor,
                                    ),
                                  ),
                                ),
                                MyText(
                                  text: "ProductDetailsScreen.detailsTile".tr,
                                  color: MyTheme.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                            Divider(),
                            controller.matchedVariation.value != null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        children: [
                                          MyText(
                                            text:
                                                "${'ProductDetailsScreen.specifications'.tr}:",
                                            color: MyTheme.textColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          ...(controller.matchedVariation.value!
                                                      .Values ??
                                                  [])
                                              .map(
                                                (e) => e.attribute!.Type
                                                            .toString() ==
                                                        "images"
                                                    ? Container(
                                                        width: 80,
                                                        height: 35,
                                                        margin:
                                                            const EdgeInsetsDirectional
                                                                .only(start: 6),
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: CachedNetworkImageProvider(
                                                                  "${NetworkURLs.getMediaServer()}${e.ValueAr}")),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            MyTheme
                                                                .buttonsRadius,
                                                          ),
                                                          color: MyTheme
                                                              .buttonColor,
                                                        ),
                                                      )
                                                    : Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8,
                                                        ),
                                                        margin:
                                                            const EdgeInsetsDirectional
                                                                .only(start: 6),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            MyTheme
                                                                .buttonsRadius,
                                                          ),
                                                          color: MyTheme
                                                              .buttonColor,
                                                        ),
                                                        child: MyText(
                                                            text: e.ValueAr
                                                                .toString()),
                                                      ),
                                              )
                                              .toList()
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          MyText(
                                            text:
                                                "${'ProductDetailsScreen.price'.tr}:",
                                            color: MyTheme.textColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          MyText(
                                            text:
                                                "${controller.matchedVariation.value?.Price.toString()}${LocalizationService.getCurrentLocale().languageCode == "ar" ? "ل.س" : "SYP"}",
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          MyText(
                                            text:
                                                "${'ProductDetailsScreen.QTY'.tr}:",
                                            color: MyTheme.textColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          MyText(
                                            text: int.parse(controller
                                                        .matchedVariation
                                                        .value!
                                                        .Stock!) >
                                                    0
                                                ? controller.matchedVariation
                                                    .value!.Stock
                                                    .toString()
                                                : 'ProductDetailsScreen.OOS'.tr,
                                            color: int.parse(controller
                                                        .matchedVariation
                                                        .value!
                                                        .Stock!) >
                                                    0
                                                ? MyTheme.greenColor
                                                : MyTheme.warnColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      int.parse(controller.matchedVariation
                                                  .value!.Stock!) >
                                              0
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: MyTheme.borderColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  MyTheme.buttonsRadius,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: MyTheme
                                                                .mainColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            MyTheme
                                                                .buttonsRadius,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () =>
                                                                  controller
                                                                      .increaseOrderQTY(),
                                                              child: Container(
                                                                // height: 55,
                                                                // width: 50,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal: 6,
                                                                  vertical: 4,
                                                                ),
                                                                // decoration:
                                                                //     BoxDecoration(
                                                                //   borderRadius:
                                                                //       BorderRadius
                                                                //           .circular(
                                                                //     8,
                                                                //   ),
                                                                //   color: MyTheme
                                                                //       .buttonColor,
                                                                //   border: Border
                                                                //       .all(
                                                                //     color: MyTheme
                                                                //         .borderColor,
                                                                //     width: 2,
                                                                //   ),
                                                                // ),
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    // color:
                                                                    //     MyTheme.iconColor,
                                                                    color: MyTheme
                                                                        .textColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 6,
                                                            ),
                                                            Container(
                                                              height: 45,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 8,
                                                              ),
                                                              // decoration:
                                                              //     BoxDecoration(
                                                              //   borderRadius:
                                                              //       BorderRadius
                                                              //           .circular(
                                                              //     8,
                                                              //   ),
                                                              //   // color: MyTheme
                                                              //   //     .secondaryColor,
                                                              //   border:
                                                              //       Border
                                                              //           .all(
                                                              //     color: MyTheme
                                                              //         .textColor,
                                                              //     width:
                                                              //         2,
                                                              //   ),
                                                              // ),
                                                              child: Center(
                                                                child: MyText(
                                                                  text: controller
                                                                      .matchedVariation
                                                                      .value!
                                                                      .orderQTY
                                                                      .toString(),
                                                                  color: MyTheme
                                                                      .textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 6,
                                                            ),
                                                            InkWell(
                                                              onTap: () =>
                                                                  controller
                                                                      .decreaseOrderQTY(),
                                                              child: Container(
                                                                // height:
                                                                // 55,
                                                                // width: 50,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal: 6,
                                                                  vertical: 4,
                                                                ),
                                                                // decoration:
                                                                //     BoxDecoration(
                                                                //   borderRadius:
                                                                //       BorderRadius.circular(
                                                                //     8,
                                                                //   ),
                                                                //   color: MyTheme
                                                                //       .secondaryColor,
                                                                //   border:
                                                                //       Border.all(
                                                                //     color:
                                                                //         MyTheme.borderColor,
                                                                //     width:
                                                                //         2,
                                                                //   ),
                                                                // ),
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    // color:
                                                                    //     MyTheme.iconColor,
                                                                    color: MyTheme
                                                                        .textColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            MyText(
                                                              text:
                                                                  "${controller.matchedVariation.value!.orderQTY}X${controller.matchedVariation.value!.Price}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              color: MyTheme
                                                                  .textColor,
                                                            ),
                                                            MyText(
                                                              text: "${int.parse(controller.matchedVariation.value!.Price.toString()) * controller.matchedVariation.value!.orderQTY}" +
                                                                  'ProductDetailsScreen.unit'
                                                                      .tr,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              color: MyTheme
                                                                  .textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  MyButton(
                                                    height: 45,
                                                    text: ((getIt
                                                                        .get<
                                                                            CartModel>()
                                                                        .CartItems ??
                                                                    [])
                                                                .where((element) =>
                                                                    element
                                                                        .variationId ==
                                                                    controller
                                                                        .matchedVariation
                                                                        .value!
                                                                        .Id)
                                                                .isNotEmpty
                                                            ? "ProductDetailsScreen.removeFromCart"
                                                            : "ProductDetailsScreen.addToCart")
                                                        .tr,
                                                    onPressed: () => (getIt
                                                                    .get<
                                                                        CartModel>()
                                                                    .CartItems ??
                                                                [])
                                                            .where((element) =>
                                                                element
                                                                    .variationId ==
                                                                controller
                                                                    .matchedVariation
                                                                    .value!
                                                                    .Id)
                                                            .isNotEmpty
                                                        ? controller
                                                            .removeMatchedVariationFromCart()
                                                        : controller
                                                            .addMatchedVariationToCart(),
                                                    backgroundColor: (getIt
                                                                    .get<
                                                                        CartModel>()
                                                                    .CartItems ??
                                                                [])
                                                            .where((element) =>
                                                                element
                                                                    .variationId ==
                                                                controller
                                                                    .matchedVariation
                                                                    .value!
                                                                    .Id)
                                                            .isNotEmpty
                                                        ? MyTheme.secondaryColor
                                                        : MyTheme.buttonColor,
                                                    icon: Icon(
                                                      (getIt
                                                                      .get<
                                                                          CartModel>()
                                                                      .CartItems ??
                                                                  [])
                                                              .where((element) =>
                                                                  element.variationId ==
                                                                  controller
                                                                      .matchedVariation
                                                                      .value!
                                                                      .Id)
                                                              .isNotEmpty
                                                          ? Icons
                                                              .remove_shopping_cart_rounded
                                                          : Icons
                                                              .shopping_bag_rounded,
                                                      color: MyTheme.iconColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )

                                          // Column(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment
                                          //             .center,
                                          //     crossAxisAlignment:
                                          //         CrossAxisAlignment
                                          //             .center,
                                          //     children: [
                                          //       MyButton(
                                          //         text:
                                          //             "ProductDetailsScreen.addToCart"
                                          //                 .tr,
                                          //         onPressed: () {},
                                          //         icon: Icon(
                                          //           Icons
                                          //               .shopping_bag_rounded,
                                          //           color:
                                          //               MyTheme.iconColor,
                                          //         ),
                                          //       ),
                                          //       MyButton(
                                          //         text:
                                          //             "ProductDetailsScreen.purchase"
                                          //                 .tr,
                                          //         onPressed: () {},
                                          //         margin: const EdgeInsets
                                          //             .only(top: 8),
                                          //         icon: Icon(
                                          //           Icons.attach_money,
                                          //           color:
                                          //               MyTheme.iconColor,
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   )
                                          : Container()
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.loading.value,
                  child: Container(
                    color: MyTheme.shadowColor.withOpacity(0.6),
                    child: const Center(
                        child: LoadingWidget(
                      loadingType: LoadingType.bar,
                    )),
                  ),
                )
              ],
            ),
          );
        });
  }
}
