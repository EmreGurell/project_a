import '../../../domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.username,
    required super.role,
    required super.status,
    required super.firstName,
    required super.lastName,
    super.profilePicture,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'] ?? "",
      username: json['username'] ?? "Bilinmiyor",
      role: json['role'] ?? "USER",
      status: json['status'] ?? "ACTIVE",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
    );
  }


  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      username: username,
      role: role,
      status: status,
      firstName: firstName,
      lastName: lastName,
      profilePicture: profilePicture,
    );
  }
}