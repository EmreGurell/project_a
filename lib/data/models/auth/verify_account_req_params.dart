class VerifyAccountReqParam {
  final String userId;
  final String code;

  VerifyAccountReqParam({required this.userId, required this.code});

  Map<String, dynamic> toMap() => {'userId': userId, 'code': code};
}
