class ResendVerificationReqParam {
  final String userId;

  ResendVerificationReqParam({required this.userId});

  Map<String, dynamic> toMap() => {'userId': userId};
}
