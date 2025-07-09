import 'package:app/components/loading_widget.dart';
import 'package:app/components/my_text.dart';
import 'package:app/components/order_history_widget.dart';
import 'package:app/controllers/order_history_screen_controller.dart';
import 'package:app/enums/loading_type.dart';
import 'package:app/theme.dart';
import 'package:app/utils/number_formater.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(OrderHistoryScreenController()),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: MyTheme.buttonColor,
          centerTitle: true,
          title: MyText(
            text: "orderScreen.title".tr,
            fontWeight: FontWeight.bold,
            size: MyTheme.textSizeXLarge,
          ),
          leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: MyTheme.iconColor,
            ),
          ),
        ),
        body: controller.loading.value
            ? const Center(
                child: LoadingWidget(
                loadingType: LoadingType.bar,
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ...controller.orders.map((e) => OrderHistoryWidget(
                            orderModel: e,
                          ))
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
