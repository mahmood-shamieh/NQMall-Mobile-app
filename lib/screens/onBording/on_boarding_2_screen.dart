import 'package:app/components/my_text.dart';
import 'package:app/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OnBoarding2Screen extends StatelessWidget {
  final VoidCallback moveToNextAction;

  const OnBoarding2Screen({super.key, required this.moveToNextAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyText(
          text: 'onBoardingScreen2.title'.tr,
          fontWeight: FontWeight.bold,
          size: MyTheme.textSizeLarge,
          color: MyTheme.textColor,
          margin: const EdgeInsets.only(
            bottom: 6,
          ),
        ),
        MyText(
          text: 'onBoardingScreen2.subTitle'.tr,
          fontWeight: FontWeight.w500,
          size: MyTheme.textSizeSmall,
          color: MyTheme.textColorLight,
          margin: const EdgeInsets.only(
            bottom: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MyTheme.shadowColor,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 10),
                width: 20,
                height: 10,
                decoration: BoxDecoration(
                  color: MyTheme.mainColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 10),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MyTheme.shadowColor,
                  ),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: moveToNextAction,
          child: Container(
            margin: const EdgeInsetsDirectional.only(top: 80, bottom: 80),
            width: 70,
            height: 70,
            child: Icon(
              FontAwesomeIcons.arrowRight,
              color: MyTheme.iconColor,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: MyTheme.buttonColor),
          ),
        )
      ],
    );
  }
}
