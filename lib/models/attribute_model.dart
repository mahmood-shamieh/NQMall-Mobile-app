// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:app/models/value_model.dart';

class AttributeModel {
  int? Id;
  String? Type;
  String? NameAr;
  String? NameEn;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? productId;
  List<ValueModel>? values;
  AttributeModel({
    this.Id,
    this.Type,
    this.NameAr,
    this.NameEn,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
    this.productId,
    this.values,
  });

  AttributeModel copyWith({
    int? Id,
    String? Type,
    String? NameAr,
    String? NameEn,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? productId,
    List<ValueModel>? values,
  }) {
    return AttributeModel(
      Id: Id ?? this.Id,
      Type: Type ?? this.Type,
      NameAr: NameAr ?? this.NameAr,
      NameEn: NameEn ?? this.NameEn,
      IsActive: IsActive ?? this.IsActive,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      productId: productId ?? this.productId,
      values: values ?? this.values,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Type': Type,
      'NameAr': NameAr,
      'NameEn': NameEn,
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'productId': productId,
      'values': values?.map((x) => x.toMap()).toList(),
    };
  }

  factory AttributeModel.fromMap(Map<String, dynamic> map) {
    return AttributeModel(
      Id: map['Id'] != null ? map['Id'] as int : null,
      Type: map['Type'] != null ? map['Type'] as String : null,
      NameAr: map['NameAr'] != null ? map['NameAr'] as String : null,
      NameEn: map['NameEn'] != null ? map['NameEn'] as String : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] as bool : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      productId: map['productId'] != null ? map['productId'] as int : null,
      values: map['values'] != null
          ? List<ValueModel>.from(
              (map['values'] as List).map<ValueModel?>(
                (x) => ValueModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeModel.fromJson(String source) =>
      AttributeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AttributeModel(Id: $Id, Type: $Type, NameAr: $NameAr, NameEn: $NameEn, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, productId: $productId, values: $values)';
  }

  @override
  bool operator ==(covariant AttributeModel other) {
    if (identical(this, other)) return true;

    return other.Id == Id &&
        other.Type == Type &&
        other.NameAr == NameAr &&
        other.NameEn == NameEn &&
        other.IsActive == IsActive &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.productId == productId &&
        listEquals(other.values, values);
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        Type.hashCode ^
        NameAr.hashCode ^
        NameEn.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        productId.hashCode ^
        values.hashCode;
  }
}
