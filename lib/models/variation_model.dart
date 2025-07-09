// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/models/order_model.dart';
import 'package:app/models/product_model.dart';
import 'package:app/models/product_variation_value_model.dart';
import 'package:flutter/foundation.dart';

import 'package:app/models/value_model.dart';

class VariationModel {
  int? Id;
  String? Price;
  String? Stock;
  int orderQTY = 1;
  List<ValueModel>? Values;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? productId;
  List<ProductVariationValueModel>? product_variation_values;
  ProductModel? product;
  VariationModel({
    this.Id,
    this.Price,
    this.Stock,
    this.Values,
    this.CreatedAt,
    this.UpdatedAt,
    this.productId,
    this.product,
    this.product_variation_values,
  });

  VariationModel copyWith(
      {int? Id,
      String? Price,
      String? Stock,
      List<ValueModel>? Values,
      DateTime? CreatedAt,
      DateTime? UpdatedAt,
      int? productId,
      List<ProductVariationValueModel>? product_variation_values,
      ProductModel? product}) {
    return VariationModel(
      Id: Id ?? this.Id,
      Price: Price ?? this.Price,
      Stock: Stock ?? this.Stock,
      Values: Values ?? this.Values,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      productId: productId ?? this.productId,
      product_variation_values:
          product_variation_values ?? this.product_variation_values,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Price': Price,
      'Stock': Stock,
      'Values': Values?.map((x) => x.toMap()).toList(),
      'product_variation_values':
          product_variation_values?.map((x) => x.toMap()).toList(),
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'productId': productId,
      'product': product?.toMap(),
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
      product_variation_values: map['product_variation_values'] != null
          ? List<ProductVariationValueModel>.from(
              (map['product_variation_values'] as List)
                  .map<ProductVariationValueModel?>(
                (x) => ProductVariationValueModel.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
      product:
          map['product'] != null ? ProductModel.fromMap(map['product']) : null,
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
