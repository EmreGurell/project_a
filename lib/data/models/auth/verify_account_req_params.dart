class VerifyAccountReqParam {
  final String email;
  final String code;

  VerifyAccountReqParam({required this.email, required this.code});

  Map<String, dynamic> toMap() => {'email': email, 'code': code};
}
