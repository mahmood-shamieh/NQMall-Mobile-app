import 'package:app/components/checkout_widget.dart';
import 'package:app/components/loading_widget.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_text.dart';
import 'package:app/components/my_text_field.dart';
import 'package:app/controllers/checkout_screen_controller.dart';
import 'package:app/enums/loading_type.dart';
import 'package:app/models/cart_model.dart';
import 'package:app/theme.dart';
import 'package:app/utils/number_formater.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatelessWidget {
  final CartModel cartModel;
  const CheckOutScreen({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(CheckOutScreenController(cartModel: cartModel)),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: MyTheme.buttonColor,
          centerTitle: true,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: MyTheme.iconColor,
            ),
          ),
          title: MyText(
            text: "checkout.title".tr,
            fontWeight: FontWeight.bold,
            size: MyTheme.textSizeXLarge,
          ),
        ),
        body: controller.loading.value
            ? Center(
                child: LoadingWidget(
                  loadingType: LoadingType.bar,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...(controller.cartModel.CartItems ?? []).map(
                        (e) => CheckOutItemWidget(cartItemModel: e),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyText(
                              text: "${"checkout.total".tr}:",
                              color: MyTheme.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            MyText(
                              text: NumberFormatter.formatNumber(
                                  (controller.cartModel.CartItems ?? [])
                                      .map((e) =>
                                          e.Quantity! *
                                          int.parse(e.PriceAtAddition!))
                                      .reduce((sum, qty) => sum! + qty!)
                                      .toDouble()),
                              color: MyTheme.textColor,
                            ),
                          ],
                        ),
                      ),
                      MyText(
                        text: 'checkout.mobile'.tr,
                        fontWeight: FontWeight.w500,
                        size: MyTheme.labelTextSize,
                        color: MyTheme.labelColor,
                        margin: const EdgeInsets.only(
                          bottom: 6,
                        ),
                      ),
                      MyTextField(
                        hintText: 'checkout.mobile'.tr,
                        controller: controller.mobile,
                        errorText: controller.errorMobile.value,
                      ),
                      MyText(
                        text: 'checkout.Note'.tr,
                        fontWeight: FontWeight.w500,
                        size: MyTheme.labelTextSize,
                        color: MyTheme.labelColor,
                        margin: const EdgeInsets.only(
                          bottom: 6,
                        ),
                      ),
                      MyTextField(
                        hintText: 'checkout.Note'.tr,
                        controller: controller.note,
                        errorText: controller.errorNote.value,
                      ),
                      MyButton(
                        margin: const EdgeInsets.only(top: 22),
                        text: 'checkout.proceed'.tr,
                        onPressed: () => controller.createOrderAction(),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
