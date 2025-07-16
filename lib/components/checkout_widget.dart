import 'package:app/components/my_text.dart';
import 'package:app/localization_service.dart';
import 'package:app/models/cart_item_model.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/theme.dart';
import 'package:app/utils/convert_to_url.dart';
import 'package:app/utils/number_formater.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutItemWidget extends StatelessWidget {
  final CartItemModel cartItemModel;
  const CheckOutItemWidget({super.key, required this.cartItemModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      // padding: const EdgeInsets.all(4),
      // decoration: BoxDecoration(
      //   color: MyTheme.borderColor,
      //   borderRadius: BorderRadius.circular(
      //     MyTheme.buttonsRadius,
      //   ),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
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
                  width: 70,
                  fit: BoxFit.fill,
                  image: CachedNetworkImageProvider(
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
                                          image: CachedNetworkImageProvider(
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
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyText(
                text:
                    "${cartItemModel.Quantity}X${NumberFormatter.formatNumber(int.parse(cartItemModel.PriceAtAddition.toString()).toDouble())}= ",
                textAlign: TextAlign.center,
                color: MyTheme.textColor,
              ),
              MyText(
                text:
                    "${NumberFormatter.formatNumber((int.parse(cartItemModel.PriceAtAddition.toString()) * cartItemModel.Quantity!).toDouble())} " +
                        'ProductDetailsScreen.unit'.tr,
                textAlign: TextAlign.center,
                color: MyTheme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Divider(
            color: MyTheme.borderColor,
            endIndent: 0,
            indent: 0,
            height: 1,
          )
        ],
      ),
    );
  }
}
