import 'dart:convert';

import 'package:app/models/value_model.dart';

class ProductVariationValueModel {
  int? Id;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? valueId;
  int? variationId;
  ValueModel? value;
  ProductVariationValueModel({
    this.Id,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
    this.valueId,
    this.variationId,
    this.value,
  });

  ProductVariationValueModel copyWith({
    int? Id,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? valueId,
    int? variationId,
    ValueModel? value,
  }) {
    return ProductVariationValueModel(
      Id: Id ?? this.Id,
      IsActive: IsActive ?? this.IsActive,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      valueId: valueId ?? this.valueId,
      variationId: variationId ?? this.variationId,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'valueId': valueId,
      'variationId': variationId,
      'value': value?.toMap(),
    };
  }

  factory ProductVariationValueModel.fromMap(Map<String, dynamic> map) {
    return ProductVariationValueModel(
      Id: map['Id'] != null ? map['Id'] : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.tryParse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.tryParse(map['UpdatedAt']) : null,
      valueId: map['valueId'] != null ? map['valueId'] : null,
      variationId: map['variationId'] != null ? map['variationId'] : null,
      value: map['value'] != null ? ValueModel.fromMap(map['value']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductVariationValueModel.fromJson(String source) =>
      ProductVariationValueModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductVariationValueModel(Id: $Id, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, valueId: $valueId, variationId: $variationId, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductVariationValueModel &&
        other.Id == Id &&
        other.IsActive == IsActive &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.valueId == valueId &&
        other.variationId == variationId &&
        other.value == value;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        valueId.hashCode ^
        variationId.hashCode ^
        value.hashCode;
  }
}
