import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_a/core/network/api_endpoints.dart';
import 'package:project_a/core/network/dio_client.dart';
import 'package:project_a/core/di/service_locator.dart';

import '../../models/auth/signin_req_params.dart';
import '../../models/auth/signup_req_params.dart';

abstract class AuthApiService {
  //Posts
  Future<Either> signUp(SignUpReqParam signUpReq);
  Future<Either> signIn(SignInReqParam signInReq);

  //Gets
  Future<Either> getMe();
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either<String, Response>> signUp(SignUpReqParam signUpReq) async {
    try {
      final response = await sl<DioClient>().post(
        ApiEndpoints.register,
        data: signUpReq.toMap(),
      );

      return Right(response);
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final String errorCode = e.response!.data['error'] ?? "UNKNOWN";
        return Left(errorCode);
      }
      return Left("NETWORK_ERROR");
    }
  }

  @override
  Future<Either<String, Response>> signIn(SignInReqParam signInReq) async {
    try {
      final response = await sl<DioClient>().post(
        ApiEndpoints.login,
        data: signInReq.toMap(),
      );

      return Right(response);
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final String errorCode = e.response!.data['error'] ?? "UNKNOWN";
        return Left(errorCode);
      }
      return Left("NETWORK_ERROR");
    }
  }

  @override
  Future<Either<String, Response>> getMe() async {
    try {
      final response = await sl<DioClient>().get(
        ApiEndpoints.me,
      ); // GET /users/me
      return Right(response);
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final String errorCode = e.response!.data['error'] ?? "UNKNOWN";
        return Left(errorCode);
      }
      return Left("NETWORK_ERROR");
    }
  }
}
