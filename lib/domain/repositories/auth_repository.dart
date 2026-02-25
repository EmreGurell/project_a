import 'package:dartz/dartz.dart';
import '../../data/models/auth/signin_req_params.dart';
import '../../data/models/auth/signup_req_params.dart';

abstract class AuthRepository {
  Future<Either> signUp(SignUpReqParam signUpReq);
  Future<Either> signIn(SignInReqParam signInReq);
  Future<bool> isAuthenticated();
  Future<Either> getMe();
}
