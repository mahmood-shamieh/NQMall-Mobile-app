import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LocalizationService extends Translations {
  // Supported languages
  static final List<Locale> supportedLocales = [
    Locale('en', 'US'), // English
    Locale('ar', 'EG'), // Arabic
  ];

  // Default language
  static const Locale fallbackLocale = Locale('en', 'US');

  // Language Map
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'bottomBar.home': 'Home',
          'bottomBar.offers': 'Offers',
          'bottomBar.profile': 'Profile',
          'bottomBar.categories': 'Catalog',
          'bottomBar.search': 'Search',
          'change_language': 'Change Language',
        },
        'ar_EG': {
          'bottomBar.home': 'الرئيسية',
          'bottomBar.offers': 'العروض',
          'bottomBar.profile': 'الحساب',
          'bottomBar.categories': 'الأصناف',
          'bottomBar.search': 'البحث',
          'change_language': 'تغيير اللغة',
        },
      };

  // Get Current Locale
  static Locale getCurrentLocale() {
    return Get.locale ?? fallbackLocale;
  }

  // Change Language
  static void changeLocale(String languageCode) {
    Locale locale =
        languageCode == 'ar' ? Locale('ar', 'EG') : Locale('en', 'US');
    Get.updateLocale(locale);
  }
}
