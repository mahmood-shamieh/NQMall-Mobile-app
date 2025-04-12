import 'package:app/components/my_button.dart';
import 'package:app/main.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: MyButton(
            text: "log out",
            onPressed: () {
              GetStorage getStorage = getIt.get<GetStorage>();
              getStorage.remove(LocalStorageKeys.userModelKey.getKey());
              if (getIt.isRegistered<UserModel>()) {
                getIt.unregister<UserModel>();
              }
              Get.offAll(() => SigninScreen());
            }),
      ),
    );
  }
}
