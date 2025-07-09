import 'package:app/controllers/base_controller.dart';
import 'package:app/exceptions/no_internet_excpetion.dart';
import 'package:app/exceptions/view_exception.dart';
import 'package:app/main.dart';
import 'package:app/models/base_response.dart';
import 'package:app/models/user_model.dart';
import 'package:get/get.dart';

class ProfileScreenController extends BaseController {
  UserModel userModel = getIt.get<UserModel>();
}
