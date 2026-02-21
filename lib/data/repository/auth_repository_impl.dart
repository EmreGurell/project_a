import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/data/source/auth/auth_api_service.dart';
import 'package:project_a/utils/local_storage/storage_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth/signin_req_params.dart';
import '../models/auth/signup_req_params.dart';
import '../source/auth/auth_local_service.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthApiService apiService;
  final AuthLocalService localService;

  AuthRepositoryImpl({
    required this.apiService,
    required this.localService,
  });

  @override
  Future<Either<String, Response>> signUp(
      SignUpReqParam signUpReq) async {

    final result = await apiService.signUp(signUpReq);

    return result.fold(
          (error) => Left(error),
          (response) async {
        final token = response.data['data']['token'];
        await localService.saveToken(token);
        return Right(response);
      },
    );
  }

  @override
  Future<Either<String, String>> signIn(
      SignInReqParam signInReq) async {

    final result = await apiService.signIn(signInReq);

    return result.fold(
          (error) => Left(error),
          (response) async {
        final token = response.data['data']['token'];
        await localService.saveToken(token);
        return Right(token);
      },
    );
  }

  @override
  Future<bool> isAuthenticated() async {
    return await localService.isAuthenticated();
  }
}