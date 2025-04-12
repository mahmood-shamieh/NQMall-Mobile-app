// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BaseResponse<T> {
  int? code;
  String? message;
  T? data;

  BaseResponse({
    this.code,
    this.message,
    required this.data,
  });

  BaseResponse<T> copyWith({
    int? code,
    String? message,
    T? data,
  }) {
    return BaseResponse<T>(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap(Map<String, dynamic> Function(T?) toDataMap) {
    return <String, dynamic>{
      'code': code,
      'message': message,
      'data': toDataMap(data),
    };
  }

  factory BaseResponse.fromMap(
    Map<String, dynamic> map,
    T Function(dynamic) fromDataMap,
  ) {
    return BaseResponse<T>(
      code: map['code'] != null ? map['code'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      data: fromDataMap(map['data']),
    );
  }

  String toJson(Map<String, dynamic> Function(T?) toDataMap) =>
      json.encode(toMap(toDataMap));

  factory BaseResponse.fromJson(
    String source,
    T Function(dynamic) fromDataMap,
  ) =>
      BaseResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
        fromDataMap,
      );

  @override
  String toString() =>
      'BaseResponse(code: $code, message: $message, data: $data)';

  @override
  bool operator ==(covariant BaseResponse<T> other) {
    if (identical(this, other)) return true;

    return other.code == code && other.message == message && other.data == data;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ data.hashCode;
}
