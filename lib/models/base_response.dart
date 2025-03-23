// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BaseREsponse<T> {
  int code;
  String message;
  T body;
  BaseREsponse({
    required this.code,
    required this.message,
    required this.body,
  });

  BaseREsponse<T> copyWith({
    int? code,
    String? message,
    T? body,
  }) {
    return BaseREsponse<T>(
      code: code ?? this.code,
      message: message ?? this.message,
      body: body ?? this.body,
    );
  }

  @override
  String toString() =>
      'BaseREsponse(code: $code, message: $message, body: $body)';

  @override
  bool operator ==(covariant BaseREsponse<T> other) {
    if (identical(this, other)) return true;

    return other.code == code && other.message == message && other.body == body;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ body.hashCode;
}
