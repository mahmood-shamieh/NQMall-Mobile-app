// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? Id;
  String? Email;
  String? PasswordHash;
  String? Password;
  String? Token;
  String? FullName;
  String? Address;
  String? PhoneNumber;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  bool? IsActive;
  String? Role;
  UserModel({
    this.Id,
    this.Email,
    this.PasswordHash,
    this.Password,
    this.Token,
    this.FullName,
    this.Address,
    this.PhoneNumber,
    this.CreatedAt,
    this.UpdatedAt,
    this.IsActive,
    this.Role,
  });

  UserModel copyWith({
    int? Id,
    String? Email,
    String? PasswordHash,
    String? Password,
    String? Token,
    String? FullName,
    String? Address,
    String? PhoneNumber,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    bool? IsActive,
    String? Role,
  }) {
    return UserModel(
      Id: Id ?? this.Id,
      Email: Email ?? this.Email,
      PasswordHash: PasswordHash ?? this.PasswordHash,
      Password: Password ?? this.Password,
      Token: Token ?? this.Token,
      FullName: FullName ?? this.FullName,
      Address: Address ?? this.Address,
      PhoneNumber: PhoneNumber ?? this.PhoneNumber,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      IsActive: IsActive ?? this.IsActive,
      Role: Role ?? this.Role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Email': Email,
      'PasswordHash': PasswordHash,
      'Password': Password,
      'Token': Token,
      'FullName': FullName,
      'Address': Address,
      'PhoneNumber': PhoneNumber,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'IsActive': IsActive,
      'Role': Role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      Id: map['Id'] != null ? map['Id'] as int : null,
      Email: map['Email'] != null ? map['Email'] as String : null,
      PasswordHash:
          map['PasswordHash'] != null ? map['PasswordHash'] as String : null,
      Password: map['Password'] != null ? map['Password'] as String : null,
      Token: map['Token'] != null ? map['Token'] as String : null,
      FullName: map['FullName'] != null ? map['FullName'] as String : null,
      Address: map['Address'] != null ? map['Address'] as String : null,
      PhoneNumber:
          map['PhoneNumber'] != null ? map['PhoneNumber'] as String : null,
      CreatedAt: map['CreatedAt'] != null
          ? DateTime.parse(map['CreatedAt'] as String)
          : null,
      UpdatedAt: map['UpdatedAt'] != null
          ? DateTime.parse(map['UpdatedAt'] as String)
          : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] as bool : null,
      Role: map['Role'] != null ? map['Role'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(Id: $Id, Email: $Email, PasswordHash: $PasswordHash, Token: $Token, FullName: $FullName, Address: $Address, PhoneNumber: $PhoneNumber, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, IsActive: $IsActive, Role: $Role)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.Id == Id &&
        other.Email == Email &&
        other.PasswordHash == PasswordHash &&
        other.Password == Password &&
        other.Token == Token &&
        other.FullName == FullName &&
        other.Address == Address &&
        other.PhoneNumber == PhoneNumber &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.IsActive == IsActive &&
        other.Role == Role;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        Email.hashCode ^
        PasswordHash.hashCode ^
        Password.hashCode ^
        Token.hashCode ^
        FullName.hashCode ^
        Address.hashCode ^
        PhoneNumber.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        IsActive.hashCode ^
        Role.hashCode;
  }
}
