class ResetPasswordReqParam {
  final String email;
  final String code;
  final String newPassword;

  ResetPasswordReqParam({
    required this.email,
    required this.code,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() => {
        'email': email,
        'code': code,
        'newPassword': newPassword,
      };
}
