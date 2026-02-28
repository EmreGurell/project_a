import 'package:project_a/core/network/api_endpoints.dart';
import 'package:project_a/core/network/dio_client.dart';

import '../../models/auth/auth_response_model.dart';
import '../../models/auth/base_response_model.dart';
import '../../models/auth/forgot_password_req_params.dart';
import '../../models/auth/resend_verification_req_params.dart';
import '../../models/auth/reset_password_req_params.dart';
import '../../models/auth/signin_req_params.dart';
import '../../models/auth/signup_req_params.dart';
import '../../models/auth/verify_account_req_params.dart';

abstract class AuthApiService {
  Future<AuthResponseModel> signUp(SignUpReqParam signUpReq);
  Future<AuthResponseModel> signIn(SignInReqParam signInReq);
  Future<BaseResponseModel> forgotPassword(ForgotPasswordReqParam param);
  Future<BaseResponseModel> resetPassword(ResetPasswordReqParam param);
  Future<BaseResponseModel> verifyAccount(VerifyAccountReqParam param);
  Future<BaseResponseModel> resendVerificationCode(ResendVerificationReqParam param);
}

class AuthApiServiceImpl implements AuthApiService {
  final DioClient dioClient;

  AuthApiServiceImpl({required this.dioClient});

  @override
  Future<AuthResponseModel> signUp(SignUpReqParam signUpReq) async {
    final response = await dioClient.post(
      ApiEndpoints.register,
      data: signUpReq.toMap(),
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> signIn(SignInReqParam signInReq) async {
    final response = await dioClient.post(
      ApiEndpoints.login,
      data: signInReq.toMap(),
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<BaseResponseModel> forgotPassword(ForgotPasswordReqParam param) async {
    final response = await dioClient.post(
      ApiEndpoints.forgotPassword,
      data: param.toMap(),
    );
    return BaseResponseModel.fromJson(response.data);
  }

  @override
  Future<BaseResponseModel> resetPassword(ResetPasswordReqParam param) async {
    final response = await dioClient.post(
      ApiEndpoints.resetPassword,
      data: param.toMap(),
    );
    return BaseResponseModel.fromJson(response.data);
  }

  @override
  Future<BaseResponseModel> verifyAccount(VerifyAccountReqParam param) async {
    final response = await dioClient.post(
      ApiEndpoints.verifyAccount,
      data: param.toMap(),
    );
    return BaseResponseModel.fromJson(response.data);
  }

  @override
  Future<BaseResponseModel> resendVerificationCode(ResendVerificationReqParam param) async {
    final response = await dioClient.post(
      ApiEndpoints.resendVerification,
      data: param.toMap(),
    );
    return BaseResponseModel.fromJson(response.data);
  }
}