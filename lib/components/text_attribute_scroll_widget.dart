import 'package:app/components/my_text.dart';
import 'package:app/localization_service.dart';
import 'package:app/models/attribute_model.dart';
import 'package:app/models/value_model.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';

class TextAttributeScrollWidget extends StatelessWidget {
  AttributeModel attributeModel;
  Function(
      {required ValueModel valueModel,
      required AttributeModel attributeModel}) action;
  ValueModel? selectedValue;
  TextAttributeScrollWidget(
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
            size: MyTheme.textSizeLarge,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
              height: 45,
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
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 8, vertical: 2),
                            margin: const EdgeInsetsDirectional.symmetric(
                                horizontal: 4, vertical: 2),
                            child: Center(
                              child: MyText(
                                text: LocalizationService.getCurrentLocale()
                                            .languageCode ==
                                        "ar"
                                    ? v.ValueAr.toString()
                                    : v.ValueEn.toString(),
                                color: selectedValue != null &&
                                        selectedValue!.Id == v.Id
                                    ? MyTheme.whiteColor
                                    : MyTheme.textColor,
                                fontWeight: selectedValue != null &&
                                        selectedValue!.Id == v.Id
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ))
        ],
      ),
    );
  }
}
