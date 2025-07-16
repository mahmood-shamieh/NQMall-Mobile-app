import 'package:app/components/my_text.dart';
import 'package:app/localization_service.dart';
import 'package:app/models/category_model.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryFilterWidget extends StatelessWidget {
  final bool selected;
  final CategoryModel categoryModel;
  final VoidCallback action;
  const CategoryFilterWidget(
      {super.key,
      required this.categoryModel,
      required this.selected,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? MyTheme.buttonColor : Colors.transparent,
          borderRadius: BorderRadius.circular(
            MyTheme.buttonsRadius,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    "${NetworkURLs.getMediaServer()}${categoryModel.ImageURL}",
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: MyText(
                text:
                    (LocalizationService.getCurrentLocale().languageCode == "ar"
                            ? categoryModel.NameAr
                            : categoryModel.NameEn)
                        .toString(),
                color: selected ? MyTheme.offWhiteColor : MyTheme.textColor,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
