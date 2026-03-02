class AuthResponseModel {
  final bool success;
  final String message;
  final String token;
  final String userId;

  // Login response'dan gelen user verisi (data.user)
  final String? loginUserEmail;
  final String? loginUserFirstName;
  final String? loginUserLastName;
  final String? loginUsername;
  final String? loginUserId;
  final bool? isVerified;
  final bool? hasProfile;

  const AuthResponseModel({
    required this.success,
    required this.message,
    required this.token,
    required this.userId,
    this.loginUserEmail,
    this.loginUserFirstName,
    this.loginUserLastName,
    this.loginUsername,
    this.loginUserId,
    this.isVerified,
    this.hasProfile,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    final user = data?['user'] as Map<String, dynamic>?;
    return AuthResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? json['error'] ?? '',
      token: data?['token'] ?? '',
      userId: data?['userId'] ?? '',
      loginUserId: user?['id']?.toString(),
      loginUserEmail: user?['email'],
      loginUserFirstName: user?['firstName'],
      loginUserLastName: user?['lastName'],
      loginUsername: user?['username'],
      isVerified: user?['isVerified'],
      hasProfile: user?['profile'] != null,
    );
  }
}
