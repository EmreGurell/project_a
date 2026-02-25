import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_a/core/network/api_endpoints.dart';
import 'package:project_a/core/network/dio_client.dart';
import 'package:project_a/core/di/service_locator.dart';

import '../../models/auth/auth_response_model.dart';
import '../../models/auth/signin_req_params.dart';
import '../../models/auth/signup_req_params.dart';

abstract class AuthApiService {
  Future<AuthResponseModel> signUp(SignUpReqParam signUpReq);
  Future<AuthResponseModel> signIn(SignInReqParam signInReq);
}
class AuthApiServiceImpl implements AuthApiService {
  final DioClient dioClient;

  AuthApiServiceImpl({
    required this.dioClient,
  });

  @override
  Future<AuthResponseModel> signUp(
      SignUpReqParam signUpReq,
      ) async {
    final response = await dioClient.post(
      ApiEndpoints.register,
      data: signUpReq.toMap(),
    );

    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> signIn(
      SignInReqParam signInReq,
      ) async {
    final response = await dioClient.post(
      ApiEndpoints.login,
      data: signInReq.toMap(),
    );

    return AuthResponseModel.fromJson(response.data);
  }
}