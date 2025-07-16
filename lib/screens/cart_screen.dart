import 'package:app/components/cart_item_widget.dart';
import 'package:app/components/loading_widget.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_text.dart';
import 'package:app/controllers/cart_screen_controller.dart';
import 'package:app/enums/loading_type.dart';
import 'package:app/localization_service.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/screens/checkout_screen.dart';
import 'package:app/theme.dart';
import 'package:app/utils/convert_to_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(CartScreenController()),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: MyTheme.buttonColor,
            centerTitle: true,
            title: MyText(
              text: "cartScreen.title".tr,
              fontWeight: FontWeight.bold,
              size: MyTheme.textSizeXLarge,
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
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: 8,
                          right: 8,
                        ),
                        width: double.infinity,
                        child: (controller.cartModel?.CartItems ?? [])
                                .isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...(controller.cartModel != null
                                      ? controller.cartModel!.CartItems!.map(
                                          (e) => CartItemWidget(
                                            cartItemModel: e,
                                            increaseAction: () => controller
                                                .incaseAction(cartItemModel: e),
                                            decreaseAction: () =>
                                                controller.decreaseAction(
                                                    cartItemModel: e),
                                            deleteAction: () => controller
                                                .addAndRemoveToDeletedCArtItems(
                                                    cartItemModel: e),
                                            isDeleted: controller
                                                .itemsToDelete.value
                                                .contains(e),
                                          ),
                                        )
                                      : []),
                                  const SizedBox(
                                    height: 400,
                                  )
                                ],
                              )
                            : Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Center(
                                  child: MyText(
                                    text: "empty".tr,
                                    color: MyTheme.textColor,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20)
                            .add(const EdgeInsets.symmetric(horizontal: 10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AnimatedScale(
                              duration: Durations.medium2,
                              scale: controller.itemsToDelete.value.isNotEmpty
                                  ? 1
                                  : 0,
                              child: MyButton(
                                margin: const EdgeInsets.only(bottom: 6),
                                text: "cartScreen.deleteButton".tr,
                                backgroundColor: MyTheme.thirdColor,
                                onPressed: () => controller.deleteCartItems(),
                              ),
                            ),
                            Visibility(
                              visible: (controller.cartModel?.CartItems ?? [])
                                  .isNotEmpty,
                              child: MyButton(
                                text: "cartScreen.submit".tr,
                                onPressed: () => Get.to(
                                  () => CheckOutScreen(
                                    cartModel: controller.cartModel!,
                                  ),
                                ),
                              ),
                            )
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
