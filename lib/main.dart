import 'package:app/components/my_button.dart';
import 'package:app/components/style_widget.dart';
import 'package:app/localization_service.dart';
import 'package:app/network/api_hundler.dart';
import 'package:app/network/network_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

GetIt getIt = GetIt.I;
void main() async {
  await GetStorage.init();
  getIt.registerSingleton(LocalizationService());
  getIt.registerSingleton(NetworkURLs());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: getIt.get<LocalizationService>(),
      locale: LocalizationService.getCurrentLocale(), // Set default locale
      fallbackLocale: LocalizationService.fallbackLocale, // Fallback locale
      home: StyleWidget(),
    );
  }
}
