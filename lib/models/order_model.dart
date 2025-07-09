import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:app/models/order_item_model.dart';
import 'package:app/models/order_status_model.dart';

class OrderModel {
  int? Id;
  String? OrderNumber;
  String? PaymentMethod;
  String? PaymentStatus;
  String? mobile;
  String? Notes;
  String? ResponseNote;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? userId;
  int? orderStatusId;
  List<OrderItemModel>? orderItems;
  OrderStatusModel? orderStatus;
  OrderModel({
    this.Id,
    this.OrderNumber,
    this.PaymentMethod,
    this.PaymentStatus,
    this.mobile,
    this.Notes,
    this.ResponseNote,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
    this.userId,
    this.orderStatusId,
    this.orderItems,
    this.orderStatus,
  });

  OrderModel copyWith({
    int? Id,
    String? OrderNumber,
    String? PaymentMethod,
    String? PaymentStatus,
    String? mobile,
    String? Notes,
    String? ResponseNote,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? userId,
    int? orderStatusId,
    List<OrderItemModel>? orderItems,
    OrderStatusModel? orderStatus,
  }) {
    return OrderModel(
      Id: Id ?? this.Id,
      OrderNumber: OrderNumber ?? this.OrderNumber,
      PaymentMethod: PaymentMethod ?? this.PaymentMethod,
      PaymentStatus: PaymentStatus ?? this.PaymentStatus,
      mobile: mobile ?? this.mobile,
      Notes: Notes ?? this.Notes,
      ResponseNote: ResponseNote ?? this.ResponseNote,
      IsActive: IsActive ?? this.IsActive,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      userId: userId ?? this.userId,
      orderStatusId: orderStatusId ?? this.orderStatusId,
      orderItems: orderItems ?? this.orderItems,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'OrderNumber': OrderNumber,
      'PaymentMethod': PaymentMethod,
      'PaymentStatus': PaymentStatus,
      'mobile': mobile,
      'Notes': Notes,
      'ResponseNote': ResponseNote,
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'userId': userId,
      'orderStatusId': orderStatusId,
      'orderItems': orderItems?.map((x) => x?.toMap())?.toList(),
      'orderStatus': orderStatus?.toMap(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      Id: map['Id'] != null ? map['Id'] : null,
      OrderNumber: map['OrderNumber'] != null ? map['OrderNumber'] : null,
      PaymentMethod: map['PaymentMethod'] != null ? map['PaymentMethod'] : null,
      PaymentStatus: map['PaymentStatus'] != null ? map['PaymentStatus'] : null,
      mobile: map['mobile'] != null ? map['mobile'] : null,
      Notes: map['Notes'] != null ? map['Notes'] : null,
      ResponseNote: map['ResponseNote'] != null ? map['ResponseNote'] : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      userId: map['userId'] != null ? map['userId'] : null,
      orderStatusId: map['orderStatusId'] != null ? map['orderStatusId'] : null,
      orderItems: map['orderItems'] != null
          ? List<OrderItemModel>.from(
              map['orderItems']?.map((x) => OrderItemModel.fromMap(x)))
          : null,
      orderStatus: map['orderStatus'] != null
          ? OrderStatusModel.fromMap(map['orderStatus'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(Id: $Id, OrderNumber: $OrderNumber, PaymentMethod: $PaymentMethod, PaymentStatus: $PaymentStatus, mobile: $mobile, Notes: $Notes, ResponseNote: $ResponseNote, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, userId: $userId, orderStatusId: $orderStatusId, orderItems: $orderItems, orderStatus: $orderStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.Id == Id &&
        other.OrderNumber == OrderNumber &&
        other.PaymentMethod == PaymentMethod &&
        other.PaymentStatus == PaymentStatus &&
        other.mobile == mobile &&
        other.Notes == Notes &&
        other.ResponseNote == ResponseNote &&
        other.IsActive == IsActive &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.userId == userId &&
        other.orderStatusId == orderStatusId &&
        listEquals(other.orderItems, orderItems) &&
        other.orderStatus == orderStatus;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        OrderNumber.hashCode ^
        PaymentMethod.hashCode ^
        PaymentStatus.hashCode ^
        mobile.hashCode ^
        Notes.hashCode ^
        ResponseNote.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        userId.hashCode ^
        orderStatusId.hashCode ^
        orderItems.hashCode ^
        orderStatus.hashCode;
  }
}
