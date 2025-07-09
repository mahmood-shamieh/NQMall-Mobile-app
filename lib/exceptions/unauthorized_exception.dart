import 'package:app/exceptions/my_exception.dart';

class UnAuthorizedException extends MyException {
  UnAuthorizedException({String? message, int? statusCode, dynamic data})
      : super(message: message, statusCode: statusCode, data: data);
}
