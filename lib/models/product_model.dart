// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/models/attribute_model.dart';
import 'package:app/models/variation_model.dart';
import 'package:flutter/foundation.dart';

import 'package:app/models/brand_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/media_model.dart';

class ProductModel {
  int? Id;
  int? Price;
  int? SalePrice;
  String? NameAr;
  String? NameEn;
  String? DescriptionAr;
  String? DescriptionEn;
  Map<String, dynamic>? DetailsAr;
  Map<String, dynamic>? DetailsEn;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? userId;
  int? categoryId;
  int? brandId;
  BrandModel? brand;
  CategoryModel? category;
  List<MediaModel>? media;
  List<AttributeModel>? attributes;
  List<VariationModel>? variations;
  ProductModel({
    this.Id,
    this.Price,
    this.SalePrice,
    this.NameAr,
    this.NameEn,
    this.DescriptionAr,
    this.DescriptionEn,
    this.DetailsAr,
    this.DetailsEn,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
    this.userId,
    this.categoryId,
    this.brandId,
    this.brand,
    this.category,
    this.media,
    this.attributes,
    this.variations,
  });

  ProductModel copyWith({
    int? Id,
    int? Price,
    int? SalePrice,
    String? NameAr,
    String? NameEn,
    String? DescriptionAr,
    String? DescriptionEn,
    Map<String, dynamic>? DetailsAr,
    Map<String, dynamic>? DetailsEn,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? userId,
    int? categoryId,
    int? brandId,
    BrandModel? brand,
    CategoryModel? category,
    List<MediaModel>? media,
    List<AttributeModel>? attributes,
    List<VariationModel>? variations,
  }) {
    return ProductModel(
      Id: Id ?? this.Id,
      Price: Price ?? this.Price,
      SalePrice: SalePrice ?? this.SalePrice,
      NameAr: NameAr ?? this.NameAr,
      NameEn: NameEn ?? this.NameEn,
      DescriptionAr: DescriptionAr ?? this.DescriptionAr,
      DescriptionEn: DescriptionEn ?? this.DescriptionEn,
      DetailsAr: DetailsAr ?? this.DetailsAr,
      DetailsEn: DetailsEn ?? this.DetailsEn,
      IsActive: IsActive ?? this.IsActive,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      media: media ?? this.media,
      attributes: attributes ?? this.attributes,
      variations: variations ?? this.variations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Price': Price,
      'SalePrice': SalePrice,
      'NameAr': NameAr,
      'NameEn': NameEn,
      'DescriptionAr': DescriptionAr,
      'DescriptionEn': DescriptionEn,
      'DetailsAr': DetailsAr,
      'DetailsEn': DetailsEn,
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'userId': userId,
      'categoryId': categoryId,
      'brandId': brandId,
      'brand': brand?.toMap(),
      'category': category?.toMap(),
      'media': media?.map((x) => x.toMap()).toList(),
      'attributes': attributes?.map((x) => x.toMap()).toList(),
      'variations': variations?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      Id: map['Id'] != null ? map['Id'] as int : null,
      Price: map['Price'] != null ? map['Price'] as int : null,
      SalePrice: map['SalePrice'] != null ? map['SalePrice'] as int : null,
      NameAr: map['NameAr'] != null ? map['NameAr'] as String : null,
      NameEn: map['NameEn'] != null ? map['NameEn'] as String : null,
      DescriptionAr:
          map['DescriptionAr'] != null ? map['DescriptionAr'] as String : null,
      DescriptionEn:
          map['DescriptionEn'] != null ? map['DescriptionEn'] as String : null,
      DetailsAr: map['DetailsAr'] != null
          ? Map<String, dynamic>.from(
              (map['DetailsAr'] as Map<String, dynamic>))
          : null,
      DetailsEn: map['DetailsEn'] != null
          ? Map<String, dynamic>.from(
              (map['DetailsEn'] as Map<String, dynamic>))
          : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] as bool : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      brandId: map['brandId'] != null ? map['brandId'] as int : null,
      brand: map['brand'] != null
          ? BrandModel.fromMap(map['brand'] as Map<String, dynamic>)
          : null,
      category: map['category'] != null
          ? CategoryModel.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      media: map['media'] != null
          ? List<MediaModel>.from(
              (map['media'] as List).map<MediaModel?>(
                (x) => MediaModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      attributes: map['attributes'] != null
          ? List<AttributeModel>.from(
              (map['attributes'] as List).map<AttributeModel?>(
                (x) => AttributeModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      variations: map['variations'] != null
          ? List<VariationModel>.from(
              (map['variations'] as List).map<VariationModel?>(
                (x) => VariationModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(Id: $Id, Price: $Price, SalePrice: $SalePrice, NameAr: $NameAr, NameEn: $NameEn, DescriptionAr: $DescriptionAr, DescriptionEn: $DescriptionEn, DetailsAr: $DetailsAr, DetailsEn: $DetailsEn, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, userId: $userId, categoryId: $categoryId, brandId: $brandId, brand: $brand, category: $category, media: $media, attributes: $attributes)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.Id == Id &&
        other.Price == Price &&
        other.SalePrice == SalePrice &&
        other.NameAr == NameAr &&
        other.NameEn == NameEn &&
        other.DescriptionAr == DescriptionAr &&
        other.DescriptionEn == DescriptionEn &&
        mapEquals(other.DetailsAr, DetailsAr) &&
        mapEquals(other.DetailsEn, DetailsEn) &&
        other.IsActive == IsActive &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.userId == userId &&
        other.categoryId == categoryId &&
        other.brandId == brandId &&
        other.brand == brand &&
        other.category == category &&
        listEquals(other.media, media) &&
        listEquals(other.attributes, attributes);
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        Price.hashCode ^
        SalePrice.hashCode ^
        NameAr.hashCode ^
        NameEn.hashCode ^
        DescriptionAr.hashCode ^
        DescriptionEn.hashCode ^
        DetailsAr.hashCode ^
        DetailsEn.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        userId.hashCode ^
        categoryId.hashCode ^
        brandId.hashCode ^
        brand.hashCode ^
        category.hashCode ^
        media.hashCode ^
        attributes.hashCode;
  }
}
