class SignInReqParam {
  final String? username;
  final String email;
  final String password;

  SignInReqParam({
    this.username,
    required this.email,
    required this.password,
  });

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      'username':username,
      'email':email,
      'password':password
    };
  }
}
