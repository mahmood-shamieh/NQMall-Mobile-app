// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:app/models/value_model.dart';

class VariationModel {
  int? Id;
  String? Price;
  String? Stock;
  List<ValueModel>? Values;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? productId;
  VariationModel({
    this.Id,
    this.Price,
    this.Stock,
    this.Values,
    this.CreatedAt,
    this.UpdatedAt,
    this.productId,
  });

  VariationModel copyWith({
    int? Id,
    String? Price,
    String? Stock,
    List<ValueModel>? Values,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? productId,
  }) {
    return VariationModel(
      Id: Id ?? this.Id,
      Price: Price ?? this.Price,
      Stock: Stock ?? this.Stock,
      Values: Values ?? this.Values,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Price': Price,
      'Stock': Stock,
      'Values': Values?.map((x) => x.toMap()).toList(),
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'productId': productId,
    };
  }

  factory VariationModel.fromMap(Map<String, dynamic> map) {
    return VariationModel(
      Id: map['Id'] != null ? map['Id'] as int : null,
      Price: map['Price'] != null ? map['Price'] as String : null,
      Stock: map['Stock'] != null ? map['Stock'] as String : null,
      productId: map['productId'] != null ? map['productId'] as int : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      Values: map['Values'] != null
          ? List<ValueModel>.from(
              (map['Values'] as List).map<ValueModel?>(
                (x) => ValueModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VariationModel.fromJson(String source) =>
      VariationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VariationModel(Id: $Id, Price: $Price, Stock: $Stock, Values: $Values)';
  }

  @override
  bool operator ==(covariant VariationModel other) {
    if (identical(this, other)) return true;

    return other.Id == Id &&
        other.Price == Price &&
        other.Stock == Stock &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.productId == productId &&
        listEquals(other.Values, Values);
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        Price.hashCode ^
        Stock.hashCode ^
        UpdatedAt.hashCode ^
        CreatedAt.hashCode ^
        productId.hashCode ^
        Values.hashCode;
  }
}
