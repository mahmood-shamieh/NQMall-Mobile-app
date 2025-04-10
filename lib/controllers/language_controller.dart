import 'package:app/utils/languages_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../localization_service.dart';

class LanguageController extends GetxController {
  var currentLocale = LocalizationService.getCurrentLocale().obs;

  void changeLanguages({required Languages lang}) {
    if (lang.code == Languages.english.code) {
      LocalizationService.changeLocale('en');
      currentLocale.value = const Locale('en', 'US');
    } else if (lang.code == Languages.arabic.code) {
      LocalizationService.changeLocale('ar');
      currentLocale.value = const Locale('ar', 'EG');
    }
    print(currentLocale.value.countryCode);
  }
}
