import 'package:app/components/my_text.dart';
import 'package:app/localization_service.dart';
import 'package:app/models/attribute_model.dart';
import 'package:app/models/value_model.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageAttributeScrollWidget extends StatelessWidget {
  AttributeModel attributeModel;
  ValueModel? selectedValue;
  Function(
      {required ValueModel valueModel,
      required AttributeModel attributeModel}) action;
  ImageAttributeScrollWidget(
      {super.key,
      required this.attributeModel,
      required this.action,
      this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text:
                "${LocalizationService.getCurrentLocale().languageCode == "ar" ? attributeModel.NameAr.toString() : attributeModel.NameEn.toString()}:",
            color: MyTheme.textColor,
            fontWeight: FontWeight.w500,
            size: MyTheme.textSizeLarge,
          ),
          SizedBox(
              height: 65,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: (attributeModel.values ?? [])
                    .map((v) => Stack(
                          children: [
                            InkWell(
                              onTap: () => action(
                                  valueModel: v,
                                  attributeModel: attributeModel),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyTheme.borderColor, width: 2),
                                  color: selectedValue != null &&
                                          selectedValue!.Id == v.Id
                                      ? MyTheme.buttonColor
                                      : MyTheme.whiteColor,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                      "${NetworkURLs.getMediaServer()}${LocalizationService.getCurrentLocale().languageCode == "ar" ? v.ValueAr.toString() : v.ValueEn.toString()}",
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    MyTheme.buttonsRadius,
                                  ),
                                ),
                                margin: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 4, vertical: 2),
                              ),
                            ),
                            selectedValue != null && selectedValue!.Id == v.Id
                                ? Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: MyTheme.buttonColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: MyTheme.whiteColor,
                                      size: 20,
                                    ),
                                  )
                                : Container(),
                          ],
                        ))
                    .toList(),
              ))
        ],
      ),
    );
  }
}
