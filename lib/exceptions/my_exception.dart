class MyException implements Exception {
  String? message;
  int? statusCode;
  dynamic data;
  MyException(this.message, this.data, this.statusCode);
}
