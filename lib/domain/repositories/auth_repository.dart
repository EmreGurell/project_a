import 'package:dartz/dartz.dart';
import '../../data/models/auth/forgot_password_req_params.dart';
import '../../data/models/auth/resend_verification_req_params.dart';
import '../../data/models/auth/reset_password_req_params.dart';
import '../../data/models/auth/signin_req_params.dart';
import '../../data/models/auth/signup_req_params.dart';
import '../../data/models/auth/verify_account_req_params.dart';

abstract class AuthRepository {
  Future<Either> signUp(SignUpReqParam signUpReq);
  Future<Either> signIn(SignInReqParam signInReq);
  Future<bool> isAuthenticated();
  Future<Either<String, void>> logout();
  Future<Either<String, void>> forgotPassword(ForgotPasswordReqParam param);
  Future<Either<String, void>> resetPassword(ResetPasswordReqParam param);
  Future<Either<String, void>> verifyAccount(VerifyAccountReqParam param);
  Future<Either<String, void>> resendVerificationCode(ResendVerificationReqParam param);
}
