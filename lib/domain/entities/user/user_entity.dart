class UserEntity {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String status;
  final String? profilePicture;
  final bool hasProfile;
  final bool isVerified;

  UserEntity({
    this.profilePicture,
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.status,
    this.hasProfile = false,
    this.isVerified = false,
  });
}
