import 'dart:math';

import 'package:app/components/my_text.dart';
import 'package:app/localization_service.dart';
import 'package:app/models/category_model.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/theme.dart';
import 'package:app/utils/convert_to_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel categoryModel;
  final VoidCallback? action;
  const CategoryWidget({super.key, required this.categoryModel, this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MyTheme.buttonsRadius),
                  color: MyTheme.borderColor,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          "${NetworkURLs.getMediaServer()}${categoryModel.ImageURL!.convertToUrl()}"))),
            ),
          ),
          MyText(
            text: LocalizationService.getCurrentLocale().languageCode == "ar"
                ? categoryModel.NameAr.toString()
                : categoryModel.NameEn.toString(),
            textAlign: TextAlign.center,
            color: MyTheme.textColor,
          ),
        ],
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
