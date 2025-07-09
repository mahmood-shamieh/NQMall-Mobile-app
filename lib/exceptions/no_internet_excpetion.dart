import 'package:app/exceptions/my_exception.dart';

class NoInternetException extends MyException {
  NoInternetException({String? message, int? statusCode, dynamic data})
      : super(message: message, statusCode: statusCode, data: data);
}
