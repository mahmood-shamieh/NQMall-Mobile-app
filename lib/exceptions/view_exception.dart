import 'package:app/exceptions/my_exception.dart';

class ViewException extends MyException {
  ViewException({String? message, int? statusCode, dynamic data})
      : super(message, statusCode, data);
}
