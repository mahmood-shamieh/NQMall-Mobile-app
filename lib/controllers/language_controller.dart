import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../localization_service.dart';

class LanguageController extends GetxController {
  var currentLocale = LocalizationService.getCurrentLocale().obs;

  void toggleLanguage() {
    if (currentLocale.value.languageCode == 'en') {
      LocalizationService.changeLocale('ar');
      currentLocale.value = Locale('ar', 'EG');
    } else {
      LocalizationService.changeLocale('en');
      currentLocale.value = Locale('en', 'US');
    }
  }
}
