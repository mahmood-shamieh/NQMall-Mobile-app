import 'dart:math';

import 'package:app/components/my_text.dart';
import 'package:app/localization_service.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/product_model.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/theme.dart';
import 'package:app/utils/convert_to_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback? action;
  const ProductWidget({super.key, required this.productModel, this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: MyTheme.cardColor,
            borderRadius: BorderRadius.circular(MyTheme.buttonsRadius)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MyTheme.buttonsRadius),
                    color: MyTheme.borderColor,
                    image: DecorationImage(
                        image: NetworkImage(
                            "${NetworkURLs.getMediaServer()}${productModel.media?[0].URL?.convertToUrl()}"))),
              ),
            ),
            MyText(
              text: LocalizationService.getCurrentLocale().languageCode == "ar"
                  ? productModel.NameAr.toString()
                  : productModel.NameEn.toString(),
              color: MyTheme.textColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MyText(
                    text:
                        "${productModel.Price.toString()}${'ProductDetailsScreen.unit'.tr}",
                    color: MyTheme.thirdColor,
                    fontWeight: productModel.SalePrice != null &&
                            productModel.SalePrice != 0
                        ? FontWeight.normal
                        : FontWeight.bold,
                    textAlign: TextAlign.center,
                    size: 14,
                    textDecoration: productModel.SalePrice != null &&
                            productModel.SalePrice != 0
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: productModel.SalePrice != null &&
                      productModel.SalePrice != 0,
                  child: Expanded(
                    child: MyText(
                      text:
                          "${productModel.SalePrice.toString()}${'ProductDetailsScreen.unit'.tr}",
                      color: MyTheme.thirdColor,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Expanded(
            //       child: InkWell(
            //         child: Container(
            //           padding: const EdgeInsets.all(2),
            //           decoration: BoxDecoration(
            //             color: MyTheme.buttonColor,
            //             borderRadius: BorderRadius.circular(
            //               MyTheme.buttonsRadius / 2,
            //             ),
            //           ),
            //           child: Icon(
            //             Icons.favorite,
            //             color: MyTheme.whiteColor,
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 12,
            //     ),
            //     Expanded(
            //       child: InkWell(
            //         child: Container(
            //           padding: const EdgeInsets.all(2),
            //           decoration: BoxDecoration(
            //             color: MyTheme.secondaryColor,
            //             borderRadius: BorderRadius.circular(
            //               MyTheme.buttonsRadius / 2,
            //             ),
            //           ),
            //           child: Icon(
            //             Icons.info,
            //             color: MyTheme.whiteColor,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255, // Full opacity
      random.nextInt(256), // Red (0–255)
      random.nextInt(256), // Green (0–255)
      random.nextInt(256), // Blue (0–255)
    );
  }
}
