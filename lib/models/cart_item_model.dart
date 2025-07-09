import 'dart:convert';

import 'package:app/models/media_model.dart';
import 'package:app/models/product_model.dart';
import 'package:app/models/variation_model.dart';

class CartItemModel {
  int? Id;
  int? Quantity;
  String? PriceAtAddition;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? cartId;
  int? productId;
  int? variationId;
  VariationModel? variation;
  ProductModel? product;
  CartItemModel({
    this.Id,
    this.Quantity,
    this.PriceAtAddition,
    this.CreatedAt,
    this.UpdatedAt,
    this.cartId,
    this.productId,
    this.variationId,
    this.variation,
    this.product,
  });

  CartItemModel copyWith({
    int? Id,
    int? Quantity,
    String? PriceAtAddition,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? cartId,
    int? productId,
    int? variationId,
    VariationModel? variation,
    ProductModel? product,
  }) {
    return CartItemModel(
      Id: Id ?? this.Id,
      Quantity: Quantity ?? this.Quantity,
      PriceAtAddition: PriceAtAddition ?? this.PriceAtAddition,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      variationId: variationId ?? this.variationId,
      variation: variation ?? this.variation,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'Quantity': Quantity,
      'PriceAtAddition': PriceAtAddition,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'cartId': cartId,
      'productId': productId,
      'variationId': variationId,
      'variation': variation?.toMap(),
      'product': product?.toMap(),
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      Id: map['Id'] != null ? map['Id'] : null,
      Quantity: map['Quantity'] != null ? map['Quantity'] : null,
      PriceAtAddition:
          map['PriceAtAddition'] != null ? map['PriceAtAddition'] : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.tryParse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.tryParse(map['UpdatedAt']) : null,
      cartId: map['cartId'] != null ? map['cartId'] : null,
      productId: map['productId'] != null ? map['productId'] : null,
      variationId: map['variationId'] != null ? map['variationId'] : null,
      variation: map['variation'] != null
          ? VariationModel.fromMap(map['variation'])
          : null,
      product:
          map['product'] != null ? ProductModel.fromMap(map['product']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartItemModel(Id: $Id, Quantity: $Quantity, PriceAtAddition: $PriceAtAddition, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, cartId: $cartId, productId: $productId, variationId: $variationId, variation: $variation, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItemModel && other.Id == Id;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        Quantity.hashCode ^
        PriceAtAddition.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        cartId.hashCode ^
        productId.hashCode ^
        variationId.hashCode ^
        variation.hashCode ^
        product.hashCode;
  }
}
