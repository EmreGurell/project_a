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
    super.hasProfile,
    super.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? '').toString(),
      email: json['email'] ?? "",
      username: json['username'] ?? "",
      role: json['role'] ?? "",
      status: json['status'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      hasProfile: json['profile'] != null,
      isVerified: json['isVerified'] ?? false,
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
      hasProfile: hasProfile,
      isVerified: isVerified,
    );
  }
}