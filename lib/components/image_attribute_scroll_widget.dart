import 'package:app/components/my_text.dart';
import 'package:app/localization_service.dart';
import 'package:app/models/attribute_model.dart';
import 'package:app/models/value_model.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/theme.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text:
              "${LocalizationService.getCurrentLocale().languageCode == "ar" ? attributeModel.NameAr.toString() : attributeModel.NameEn.toString()}:",
          color: MyTheme.textColor,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
            height: 75,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: (attributeModel.values ?? [])
                  .map((v) => InkWell(
                        onTap: () => action(
                            valueModel: v, attributeModel: attributeModel),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: MyTheme.borderColor, width: 2),
                            color: selectedValue != null &&
                                    selectedValue!.Id == v.Id
                                ? MyTheme.buttonColor
                                : MyTheme.whiteColor,
                            borderRadius: BorderRadius.circular(
                              MyTheme.buttonsRadius,
                            ),
                          ),
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 4, vertical: 2),
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                MyTheme.buttonsRadius,
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "${NetworkURLs.getMediaServer()}${LocalizationService.getCurrentLocale().languageCode == "ar" ? v.ValueAr.toString() : v.ValueEn.toString()}",
                                ),
                              ),
                            ),
                            child: selectedValue != null &&
                                    selectedValue!.Id == v.Id
                                ? Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color.fromARGB(
                                            255, 35, 30, 26)),
                                    child: Icon(
                                      Icons.check,
                                      color: MyTheme.whiteColor,
                                      size: 40,
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                      ))
                  .toList(),
            ))
      ],
    );
  }
}
