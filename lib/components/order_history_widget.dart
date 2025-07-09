import 'package:app/components/my_text.dart';
import 'package:app/localization_service.dart';
import 'package:app/models/order_model.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/theme.dart';
import 'package:app/utils/convert_to_url.dart';
import 'package:app/utils/date_time_fomratter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OrderHistoryWidget extends StatelessWidget {
  final OrderModel orderModel;
  const OrderHistoryWidget({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 2),
      decoration: BoxDecoration(
        color: MyTheme.borderColor,
        borderRadius: BorderRadius.circular(MyTheme.buttonsRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                // ${"orderScreen.orderWord".tr}
                text: "${orderModel.Id.toString()}#",
                color: MyTheme.textColor,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: MyTheme.thirdColor,
                  borderRadius: BorderRadius.circular(
                    MyTheme.buttonsRadius,
                  ),
                ),
                child: MyText(
                  // ${"orderScreen.orderWord".tr}
                  text:
                      "${LocalizationService.getCurrentLocale().languageCode == "ar" ? orderModel.orderStatus?.NameAr.toString() : orderModel.orderStatus?.NameEn.toString()}",
                  size: MyTheme.textSizeXXSmall,
                  color: MyTheme.offWhiteColor,
                ),
              ),
            ],
          ),
          ...(orderModel.orderItems ?? []).map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  MyText(
                    text: "X${e.Quantity}",
                    size: MyTheme.textSizeXSmall,
                    color: MyTheme.textColor,
                  ),
                  MyText(
                    text:
                        (LocalizationService.getCurrentLocale().languageCode ==
                                    'ar'
                                ? e.product?.NameAr
                                : e.product?.NameEn) ??
                            '',
                    size: MyTheme.textSizeXSmall,
                    color: MyTheme.textColor,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsetsDirectional.only(start: 4),
                    decoration: BoxDecoration(
                        color: MyTheme.mainColor,
                        borderRadius: BorderRadius.circular(
                          MyTheme.buttonsRadius,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '${NetworkURLs.getMediaServer()}${e.product?.media?.first.URL.toString().convertToUrl()}'),
                        )),
                  ),
                  ...(e.variation?.Values != null
                      ? e.variation!.Values!
                          .map((value) => value.attribute!.Type == "images"
                              ? Container(
                                  height: 50,
                                  width: 50,
                                  margin: const EdgeInsetsDirectional.only(
                                      start: 4),
                                  decoration: BoxDecoration(
                                      color: MyTheme.mainColor,
                                      borderRadius: BorderRadius.circular(
                                        MyTheme.buttonsRadius,
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            '${NetworkURLs.getMediaServer()}${LocalizationService.getCurrentLocale().languageCode == 'ar' ? value.ValueAr.toString().convertToUrl() : value.ValueEn.toString().convertToUrl()}'),
                                      )),
                                )
                              : FittedBox(
                                  child: Container(
                                    height: 50,
                                    margin: const EdgeInsetsDirectional.only(
                                        start: 4),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: MyTheme.mainColor,
                                      borderRadius: BorderRadius.circular(
                                        MyTheme.buttonsRadius,
                                      ),
                                    ),
                                    child: Center(
                                      child: MyText(
                                        // ${"orderScreen.orderWord".tr}
                                        text:
                                            "${LocalizationService.getCurrentLocale().languageCode == "ar" ? value.ValueAr : value.ValueEn}",
                                        size: MyTheme.textSizeXXSmall,
                                        color: MyTheme.offWhiteColor,
                                      ),
                                    ),
                                  ),
                                ))
                      : []),
                ],
              ),
            ),
          ),
          Visibility(
              visible: orderModel.mobile != null &&
                  orderModel.mobile.toString() != '',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: '${"orderScreen.anotherMobileTitle".tr} ',
                    color: MyTheme.textColor,
                    fontWeight: FontWeight.bold,
                    size: MyTheme.textSizeXSmall,
                  ),
                  Expanded(
                    child: MyText(
                      text: orderModel.mobile ?? '',
                      color: MyTheme.textColor,
                      size: MyTheme.textSizeXSmall,
                    ),
                  ),
                ],
              )),
          Visibility(
              visible:
                  orderModel.Notes != null && orderModel.Notes.toString() != '',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: '${"orderScreen.userNote".tr} ',
                    color: MyTheme.textColor,
                    fontWeight: FontWeight.bold,
                    size: MyTheme.textSizeXSmall,
                  ),
                  Expanded(
                    child: MyText(
                      text: orderModel.Notes ?? '',
                      color: MyTheme.textColor,
                      size: MyTheme.textSizeXSmall,
                    ),
                  ),
                ],
              )),
          Visibility(
              visible: orderModel.ResponseNote != null &&
                  orderModel.ResponseNote.toString() != '',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: '${"orderScreen.responseNote".tr} ',
                    color: MyTheme.warnColor,
                    fontWeight: FontWeight.bold,
                  ),
                  Expanded(
                    child: MyText(
                      text: orderModel.ResponseNote ?? '',
                      color: MyTheme.warnColor,
                    ),
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyText(
                text: orderModel.CreatedAt!.toOrderDateFormat(),
                color: MyTheme.secondaryColor,
                size: MyTheme.textSizeXSmall,
              )
            ],
          )
        ],
      ),
    );
  }
}
