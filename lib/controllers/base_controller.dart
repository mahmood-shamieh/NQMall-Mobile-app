import 'package:app/exceptions/no_internet_excpetion.dart';
import 'package:app/exceptions/view_exception.dart';
import 'package:app/models/base_response.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  Future<BaseResponse?> callApi({required Function action}) async {
    try {
      return action();
    } on NoInternetException catch (e) {
      print(e.message);
      throw NoInternetException();
    } on ViewException catch (e) {
      print(e.message);
      throw ViewException(
          statusCode: e.statusCode, message: e.message, data: e.data);
    } catch (e) {
      e.printError();
      throw Exception("Unexpected Error: $e");
    }
  }
}
