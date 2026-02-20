class SignUpReqParam {
  final String name;
  final String surname;
  final String email;
  final String password;

  SignUpReqParam({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      'name':name,
      'surname':surname,
      'email':email,
      'password':password
    };
  }
}
