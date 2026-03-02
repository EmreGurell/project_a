class AuthEntity {
  final String token;
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? username;
  final bool hasProfile;

  const AuthEntity({
    required this.token,
    this.id = '',
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.username,
    this.hasProfile = false,
  });
}
