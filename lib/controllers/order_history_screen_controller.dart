import 'package:app/controllers/base_controller.dart';
import 'package:app/data/get_order_hoistory_api.dart';
import 'package:app/exceptions/unauthorized_exception.dart';
import 'package:app/exceptions/view_exception.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/order_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/sign_in_screen.dart';
import 'package:app/utils/local_storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrderHistoryScreenController extends BaseController {
  List<OrderModel> orders = [];
  RxBool loading = false.obs;
  @override
  void onInit() {
    getOrderHistory();
    super.onInit();
  }

  Future getOrderHistory() async {
    GetStorage getStorage = getIt.get<GetStorage>();
    if (getStorage.read(LocalStorageKeys.userModelKey.key) == null) return;
    try {
      loading(true);
      update();
      BaseResponse<List<OrderModel>> baseResponse =
          await GetOrderHistoryApi.callApi(userModel: getIt.get<UserModel>());
      orders = baseResponse.data!;
    } on UnAuthorizedException catch (e) {
      Future.delayed(
          Durations.extralong1, () => Get.offAll(() => SigninScreen()));
    } catch (e) {
      if (e is ViewException) return;
      rethrow;
    } finally {
      loading(false);
      update();
    }
  }
}
