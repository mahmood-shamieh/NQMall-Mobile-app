// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ValueModel {
  int? Id;
  String? ValueAr;
  String? ValueEn;
  String? HoverImageAr;
  String? HoverImageEn;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? attributeId;
  ValueModel({
    this.Id,
    this.ValueAr,
    this.ValueEn,
    this.HoverImageAr,
    this.HoverImageEn,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
    this.attributeId,
  });

  ValueModel copyWith({
    int? Id,
    String? ValueAr,
    String? ValueEn,
    String? HoverImageAr,
    String? HoverImageEn,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? attributeId,
  }) {
    return ValueModel(
      Id: Id ?? this.Id,
      ValueAr: ValueAr ?? this.ValueAr,
      ValueEn: ValueEn ?? this.ValueEn,
      HoverImageAr: HoverImageAr ?? this.HoverImageAr,
      HoverImageEn: HoverImageEn ?? this.HoverImageEn,
      IsActive: IsActive ?? this.IsActive,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      attributeId: attributeId ?? this.attributeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'ValueAr': ValueAr,
      'ValueEn': ValueEn,
      'HoverImageAr': HoverImageAr,
      'HoverImageEn': HoverImageEn,
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'attributeId': attributeId,
    };
  }

  factory ValueModel.fromMap(Map<String, dynamic> map) {
    return ValueModel(
      Id: map['Id'] != null ? map['Id'] as int : null,
      ValueAr: map['ValueAr'] != null ? map['ValueAr'] as String : null,
      ValueEn: map['ValueEn'] != null ? map['ValueEn'] as String : null,
      HoverImageAr:
          map['HoverImageAr'] != null ? map['HoverImageAr'] as String : null,
      HoverImageEn:
          map['HoverImageEn'] != null ? map['HoverImageEn'] as String : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] as bool : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      attributeId:
          map['attributeId'] != null ? map['attributeId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ValueModel.fromJson(String source) =>
      ValueModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ValueModel(Id: $Id, ValueAr: $ValueAr, ValueEn: $ValueEn, HoverImageAr: $HoverImageAr, HoverImageEn: $HoverImageEn, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, attributeId: $attributeId)';
  }

  @override
  bool operator ==(covariant ValueModel other) {
    if (identical(this, other)) return true;

    return other.Id == Id &&
        other.ValueAr == ValueAr &&
        other.ValueEn == ValueEn &&
        other.HoverImageAr == HoverImageAr &&
        other.HoverImageEn == HoverImageEn &&
        other.IsActive == IsActive &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.attributeId == attributeId;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        ValueAr.hashCode ^
        ValueEn.hashCode ^
        HoverImageAr.hashCode ^
        HoverImageEn.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        attributeId.hashCode;
  }
}
