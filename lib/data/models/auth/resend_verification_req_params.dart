class ResendVerificationReqParam {
  final String email;

  ResendVerificationReqParam({required this.email});

  Map<String, dynamic> toMap() => {'email': email};
}
