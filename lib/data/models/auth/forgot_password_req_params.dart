class ForgotPasswordReqParam {
  final String email;

  ForgotPasswordReqParam({required this.email});

  Map<String, dynamic> toMap() => {'email': email};
}
