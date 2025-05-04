// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MediaModel {
  int? Id;
  String? URL;
  String? Type;
  int? Size;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? productId;
  MediaModel({
    this.Id,
    this.URL,
    this.Type,
    this.Size,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
    this.productId,
  });

  MediaModel copyWith({
    int? Id,
    String? URL,
    String? Type,
    int? Size,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? productId,
  }) {
    return MediaModel(
      Id: Id ?? this.Id,
      URL: URL ?? this.URL,
      Type: Type ?? this.Type,
      Size: Size ?? this.Size,
      IsActive: IsActive ?? this.IsActive,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'URL': URL,
      'Type': Type,
      'Size': Size,
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'productId': productId,
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      Id: map['Id'] != null ? map['Id'] as int : null,
      URL: map['URL'] != null ? map['URL'] as String : null,
      Type: map['Type'] != null ? map['Type'] as String : null,
      Size: map['Size'] != null ? map['Size'] as int : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] as bool : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      productId: map['productId'] != null ? map['productId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaModel.fromJson(String source) =>
      MediaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MediaModel(Id: $Id, URL: $URL, Type: $Type, Size: $Size, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, productId: $productId)';
  }

  @override
  bool operator ==(covariant MediaModel other) {
    if (identical(this, other)) return true;

    return other.Id == Id &&
        other.URL == URL &&
        other.Type == Type &&
        other.Size == Size &&
        other.IsActive == IsActive &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        URL.hashCode ^
        Type.hashCode ^
        Size.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        productId.hashCode;
  }
}
