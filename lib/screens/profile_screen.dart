import 'package:app/components/my_button.dart';
import 'package:app/components/my_text.dart';
import 'package:app/controllers/profile_screen_controller.dart';
import 'package:app/main.dart';
import 'package:app/models/brand_model.dart';
import 'package:app/models/cart_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/order_history_screen.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/theme.dart';
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
    return GetBuilder(
        init: Get.put(ProfileScreenController()),
        builder: (controller) => Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
                      height: MediaQuery.of(context).size.height - 24,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyTheme.thirdColor, width: 2),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: MyTheme.secondaryColor,
                                  size: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: controller.userModel.FullName
                                        .toString(),
                                    color: MyTheme.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  MyText(
                                    text: controller.userModel.Email.toString(),
                                    color: MyTheme.textColor,
                                    fontWeight: FontWeight.w600,
                                    size: MyTheme.textSizeXSmall,
                                  )
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            color: MyTheme.borderColor,
                          ),
                          MyButton(
                              text: "profileScreen.orderHistory".tr,
                              icon: const Icon(
                                Icons.history,
                                color: MyTheme.iconColor,
                              ),
                              onPressed: () {
                                Get.to(() => OrderHistoryScreen());
                              }),
                          MyButton(
                              margin: const EdgeInsets.only(top: 8),
                              text: "profileScreen.logout".tr,
                              icon: const Icon(
                                Icons.exit_to_app,
                                color: MyTheme.iconColor,
                              ),
                              onPressed: () async {
                                GetStorage getStorage = getIt.get<GetStorage>();
                                getStorage.remove(
                                    LocalStorageKeys.userModelKey.getKey());
                                // await getIt.reset();
                                // GetIt.I.registerSingleton<GetStorage>(
                                //     GetStorage());

                                if (getIt.isRegistered<CartModel>()) {
                                  getIt.unregister<CartModel>();
                                }
                                if (getIt.isRegistered<UserModel>()) {
                                  getIt.unregister<UserModel>();
                                }
                                if (getIt.isRegistered<List<CategoryModel>>()) {
                                  getIt.unregister<List<CategoryModel>>();
                                }
                                if (getIt.isRegistered<List<BrandModel>>()) {
                                  getIt.unregister<List<BrandModel>>();
                                }

                                Get.offAll(() => SigninScreen());
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
