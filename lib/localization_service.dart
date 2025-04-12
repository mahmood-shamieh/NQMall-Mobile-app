import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LocalizationService extends Translations {
  // Supported languages
  static final List<Locale> supportedLocales = [
    Locale('en', 'US'), // English
    Locale('ar', 'EG'), // Arabic
  ];

  // Default language
  static const Locale fallbackLocale = Locale('ar', 'EG');

  // Language Map
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'loading': 'Loading',
          'bottomBar.home': 'Home',
          'bottomBar.offers': 'Offers',
          'bottomBar.profile': 'Profile',
          'bottomBar.categories': 'Catalog',
          'bottomBar.search': 'Search',
          'onBoardingScreen1.title': 'Shop Your Needs',
          'onBoardingScreen1.subTitle': 'Shop All Your Needs From One Place',
          'onBoardingScreen2.title': 'Shop Your Needs',
          'onBoardingScreen2.subTitle': 'Shop All Your Needs From One Place',
          'onBoardingScreen3.title': 'Shop Your Needs',
          'onBoardingScreen3.subTitle': 'Shop All Your Needs From One Place',
          'signinScreen.title': 'Welcome at 7 Days mart',
          'signinScreen.usernameTitle': 'Email or Phone',
          'signinScreen.password': 'Password',
          'signinScreen.forgetPassword': 'Forget Password?',
          'signinScreen.signinAction': 'Signin',
          'signinScreen.signupAction': 'Signup',
          'signupScreen.title': 'Welcome At 7DAYS MART',
          'signupScreen.usernameTitle': 'Email or Phone',
          'signupScreen.fullName': 'Full Name',
          'signupScreen.password': 'Password',
          'signupScreen.confirmPassword': 'Confirm Password',
          'signupScreen.phoneNumber': 'Phone',
          'signupScreen.address': 'Address',
          'signupScreen.signupAction': 'Signup',
          'signupScreen.signinAction': 'Signin',
          'change_language': 'Change Language',
          'languagesScreen.title': 'Choose Language',
          'languagesScreen.arabic': 'Arabic',
          'languagesScreen.english': 'English',
          'languagesScreen.continue': 'Continue',
          'unauthorizedDialog.title': 'Issue',
          'unauthorizedDialog.close': 'Close',
          'ViewErrorDialog.title': 'Alert',
          'ViewErrorDialog.close': 'Close',
          'homeScreen.searchFiled': 'What You Need',
          'homeScreen.offerAction': 'Read More',
          'homeScreen.title1': 'Shop By Category',
        },
        'ar_EG': {
          'loading': 'يرجى الانتظار',
          'bottomBar.home': 'الرئيسية',
          'bottomBar.offers': 'العروض',
          'bottomBar.profile': 'الحساب',
          'bottomBar.categories': 'الأصناف',
          'bottomBar.search': 'البحث',
          'onBoardingScreen1.title': 'تسوق حسب حاجتك',
          'onBoardingScreen1.subTitle': 'تسوق كل حاجياتك بمكان واحد',
          'onBoardingScreen2.title': 'عروض دائمة',
          'onBoardingScreen2.subTitle': 'عروض دائمة و الأسعار المنافسة',
          'onBoardingScreen3.title': 'توصيل خلال 30 دقيقة',
          'onBoardingScreen3.subTitle': 'توصيل خلال 30 دقيقة',
          'signinScreen.title': 'أهلاً بكم في سفن ديز مارت',
          'signinScreen.usernameTitle': 'الإيميل أو الموبايل',
          'signinScreen.password': 'كلمة المرور',
          'signinScreen.forgetPassword': 'نسيت كلمة المرور?',
          'signinScreen.signinAction': 'تسجيل الدخول',
          'signinScreen.signupAction': 'إنشاء حساب',
          'signupScreen.title': 'أهلاً بكم في سفن ديز مارت',
          'signupScreen.usernameTitle': 'الإيميل أو الموبايل',
          'signupScreen.fullName': 'الاسم الكامل',
          'signupScreen.password': 'كلمة المرور',
          'signupScreen.confirmPassword': 'تأكيد كلمة المرور',
          'signupScreen.phoneNumber': 'رقم الموبايل',
          'signupScreen.address': 'العنوان',
          'signupScreen.signupAction': 'إنشاء حساب',
          'signupScreen.signinAction': 'تسجيل الدخول',
          'change_language': 'تغيير اللغة',
          'languagesScreen.title': 'اختر اللغة',
          'languagesScreen.arabic': 'العربية',
          'languagesScreen.english': 'الإنجليزية',
          'languagesScreen.continue': 'المتابعة',
          'unauthorizedDialog.title': 'خطأ',
          'unauthorizedDialog.close': 'الغاء',
          'ViewErrorDialog.title': 'تنبيه',
          'ViewErrorDialog.close': 'الغاء',
          'homeScreen.searchFiled': 'ماذا تريد',
          'homeScreen.offerAction': 'قراءة المزيد',
          'homeScreen.title1': 'تسوق حسب الأصناف',
        },
      };

  // Get Current Locale
  static Locale getCurrentLocale() {
    return Get.locale ?? fallbackLocale;
  }

  // Change Language
  static void changeLocale(String? languageCode) {
    Locale locale =
        languageCode == 'en' ? Locale('en', 'US') : Locale('ar', 'EG');
    Get.updateLocale(locale);
  }
}
