import 'package:app/localization_service.dart';
import 'package:app/models/cart_item_model.dart';
import 'package:app/theme.dart';
import 'package:app/utils/convert_to_url.dart';
import 'package:app/utils/number_formater.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../network/network_urls.dart';
import 'my_text.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItemModel;
  final VoidCallback deleteAction, increaseAction, decreaseAction;
  final bool isDeleted;
  const CartItemWidget(
      {super.key,
      required this.isDeleted,
      required this.cartItemModel,
      required this.decreaseAction,
      required this.deleteAction,
      required this.increaseAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: isDeleted ? MyTheme.secondaryColor : MyTheme.borderColor,
        border: Border.all(
          color: MyTheme.borderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(
          MyTheme.buttonsRadius,
        ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  MyTheme.buttonsRadius,
                ),
                child: Image(
                  width: MediaQuery.of(context).size.width / 3,
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    "${NetworkURLs.getMediaServer()}${cartItemModel.product!.media!.first.URL.toString().convertToUrl()}",
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text:
                          LocalizationService.getCurrentLocale().languageCode ==
                                  "ar"
                              ? cartItemModel.product!.NameAr.toString()
                              : cartItemModel.product!.NameEn.toString(),
                      color: MyTheme.textColor,
                    ),
                    Row(
                      children: cartItemModel.variation != null &&
                              cartItemModel.variation?.Values != null
                          ? cartItemModel.variation!.Values!.map((e) {
                              return e.attribute!.Type.toString() == "list" ||
                                      e.attribute!.Type.toString() == "items"
                                  ? Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          end: 6),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: MyTheme.mainColor,
                                        borderRadius: BorderRadius.circular(
                                          MyTheme.buttonsRadius,
                                        ),
                                      ),
                                      child: MyText(
                                        text: (LocalizationService
                                                            .getCurrentLocale()
                                                        .countryCode ==
                                                    'ar'
                                                ? e.ValueAr
                                                : e.ValueEn)
                                            .toString(),
                                        color: MyTheme.offWhiteColor,
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          end: 6),
                                      width: 60,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MyTheme.buttonsRadius),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            "${NetworkURLs.getMediaServer()}${LocalizationService.getCurrentLocale().countryCode == "ar" ? e.ValueAr : e.ValueEn}",
                                          ),
                                        ),
                                      ),
                                    );
                            }).toList()
                          : [],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: MyTheme.mainColor),
                          borderRadius:
                              BorderRadius.circular(MyTheme.buttonsRadius)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: increaseAction,
                            child: Container(
                              // height: 55,
                              // width: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(
                              //     8,
                              //   ),
                              //   color: MyTheme.buttonColor,
                              //   border: Border.all(
                              //     color: MyTheme.borderColor,
                              //     width: 2,
                              //   ),
                              // ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  // color: MyTheme.iconColor,
                                  color: MyTheme.textColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 45,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(
                            //     8,
                            //   ),
                            //   // color: MyTheme
                            //   //     .secondaryColor,
                            //   border: Border.all(
                            //     color: MyTheme.textColor,
                            //     width: 2,
                            //   ),
                            // ),
                            child: Center(
                              child: MyText(
                                text: cartItemModel.Quantity.toString(),
                                color: MyTheme.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          InkWell(
                            onTap: decreaseAction,
                            child: Container(
                              // height: 55,
                              // width: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(
                              //     8,
                              //   ),
                              //   color: MyTheme.secondaryColor,
                              //   border: Border.all(
                              //     color: MyTheme.borderColor,
                              //     width: 2,
                              //   ),
                              // ),
                              child: Center(
                                child: Icon(
                                  Icons.remove,
                                  // color: MyTheme.iconColor,
                                  color: MyTheme.textColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyText(
                          text:
                              "${cartItemModel.Quantity}X${NumberFormatter.formatNumber(int.parse(cartItemModel.PriceAtAddition.toString()).toDouble())} = ",
                          textAlign: TextAlign.start,
                          color: MyTheme.textColor,
                        ),
                        MyText(
                          text:
                              "${NumberFormatter.formatNumber((int.parse(cartItemModel.PriceAtAddition.toString()) * cartItemModel.Quantity!).toDouble())} " +
                                  'ProductDetailsScreen.unit'.tr,
                          textAlign: TextAlign.start,
                          color: MyTheme.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          InkWell(
            onTap: deleteAction,
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: InkWell(
                child: isDeleted
                    ? const Icon(
                        FontAwesomeIcons.x,
                        color: MyTheme.offWhiteColor,
                      )
                    : const Icon(
                        FontAwesomeIcons.trash,
                        color: MyTheme.warnColor,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
