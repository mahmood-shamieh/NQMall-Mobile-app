// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  int? Id;
  String? NameAr;
  String? NameEn;
  String? DescriptionAr;
  String? DescriptionEn;
  String? ImageURL;
  int? ImageSize;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  CategoryModel({
    this.Id,
    this.NameAr,
    this.NameEn,
    this.DescriptionAr,
    this.DescriptionEn,
    this.ImageURL,
    this.ImageSize,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
  });

  CategoryModel copyWith({
    int? Id,
    String? NameAr,
    String? NameEn,
    String? DescriptionAr,
    String? DescriptionEn,
    String? ImageURL,
    int? ImageSize,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
  }) {
    return CategoryModel(
      Id: Id ?? this.Id,
      NameAr: NameAr ?? this.NameAr,
      NameEn: NameEn ?? this.NameEn,
      DescriptionAr: DescriptionAr ?? this.DescriptionAr,
      DescriptionEn: DescriptionEn ?? this.DescriptionEn,
      ImageURL: ImageURL ?? this.ImageURL,
      ImageSize: ImageSize ?? this.ImageSize,
      IsActive: IsActive ?? this.IsActive,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'NameAr': NameAr,
      'NameEn': NameEn,
      'DescriptionAr': DescriptionAr,
      'DescriptionEn': DescriptionEn,
      'ImageURL': ImageURL,
      'ImageSize': ImageSize,
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      Id: map['Id'] != null ? map['Id'] as int : null,
      NameAr: map['NameAr'] != null ? map['NameAr'] as String : null,
      NameEn: map['NameEn'] != null ? map['NameEn'] as String : null,
      DescriptionAr:
          map['DescriptionAr'] != null ? map['DescriptionAr'] as String : null,
      DescriptionEn:
          map['DescriptionEn'] != null ? map['DescriptionEn'] as String : null,
      ImageURL: map['ImageURL'] != null ? map['ImageURL'] as String : null,
      ImageSize: map['ImageSize'] != null ? map['ImageSize'] as int : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] as bool : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryModel(Id: $Id, NameAr: $NameAr, NameEn: $NameEn, DescriptionAr: $DescriptionAr, DescriptionEn: $DescriptionEn, ImageURL: $ImageURL, ImageSize: $ImageSize, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt)';
  }

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.Id == Id &&
        other.NameAr == NameAr &&
        other.NameEn == NameEn &&
        other.DescriptionAr == DescriptionAr &&
        other.DescriptionEn == DescriptionEn &&
        other.ImageURL == ImageURL &&
        other.ImageSize == ImageSize &&
        other.IsActive == IsActive &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        NameAr.hashCode ^
        NameEn.hashCode ^
        DescriptionAr.hashCode ^
        DescriptionEn.hashCode ^
        ImageURL.hashCode ^
        ImageSize.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode;
  }
}
