class AuthResponseModel {
  final bool success;
  final String message;
  final String token;

  const AuthResponseModel({
    required this.success,
    required this.message,
    required this.token,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'],
      message: json['message'],
      token: json['data']['token'],
    );
  }
}