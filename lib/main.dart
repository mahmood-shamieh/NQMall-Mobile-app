import 'package:app/components/my_button.dart';
import 'package:app/components/style_widget.dart';
import 'package:app/firebase_options.dart';
import 'package:app/localization_service.dart';
import 'package:app/models/user_model.dart';
import 'package:app/network/api_hundler.dart';
import 'package:app/network/network_urls.dart';
import 'package:app/screens/languages_screen%20.dart';
import 'package:app/screens/sign_Up_screen.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:app/services/notification_service.dart';
import 'package:app/utils/languages_enum.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

GetIt getIt = GetIt.I;
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Notification Service
  final notificationService = Get.put(NotificationService());
  await notificationService.init();
  await GetStorage.init();
  getIt.registerSingleton<GetStorage>(GetStorage());
  getIt.registerSingleton<PersistentTabController>(PersistentTabController(
    initialIndex: 0,
  ));
  // print(GetStorage().read(LocalStorageKeys.userModelKey.getKey()));
  // GetStorage().write(
  //     LocalStorageKeys.userModelKey.getKey(),
  //     UserModel(Email: "mahmood@mahmood.mahmood", PasswordHash: "11111111")
  //         .toJson());
  // GetStorage().erase();
  LocalizationService localizationService = LocalizationService();
  LocalizationService.changeLocale(
      GetStorage().read(LocalStorageKeys.currentLanguages.getKey()));
  getIt.registerSingleton(localizationService);
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
      textDirection: LocalizationService.getCurrentLocale().languageCode ==
              Languages.arabic.code
          ? TextDirection.rtl
          : TextDirection.ltr,
      translations: getIt.get<LocalizationService>(),
      locale: LocalizationService.getCurrentLocale(), // Set default locale
      fallbackLocale: LocalizationService.fallbackLocale, // Fallback locale
      home: SplashScreen(),
    );
  }
}
