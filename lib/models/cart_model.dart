import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:app/models/cart_item_model.dart';

class CartModel {
  int? Id;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? userId;
  List<CartItemModel>? CartItems;
  CartModel({
    this.Id,
    this.CreatedAt,
    this.UpdatedAt,
    this.userId,
    this.CartItems,
  });

  CartModel copyWith({
    int? Id,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? userId,
    List<CartItemModel>? CartItems,
  }) {
    return CartModel(
      Id: Id ?? this.Id,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      userId: userId ?? this.userId,
      CartItems: CartItems ?? this.CartItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'userId': userId,
      'CartItems': CartItems?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      Id: map['Id'] != null ? map['Id'] : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.tryParse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.tryParse(map['UpdatedAt']) : null,
      userId: map['userId'] != null ? map['userId'] : null,
      CartItems: map['CartItems'] != null
          ? List<CartItemModel>.from(
              map['CartItems']?.map((x) => CartItemModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartModel(Id: $Id, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, userId: $userId, CartItems: $CartItems)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartModel &&
        other.Id == Id &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.userId == userId &&
        listEquals(other.CartItems, CartItems);
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        userId.hashCode ^
        CartItems.hashCode;
  }
}
