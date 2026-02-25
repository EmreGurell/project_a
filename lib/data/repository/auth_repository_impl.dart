import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_a/data/source/auth/auth_api_service.dart';
import '../../domain/entities/auth_entity.dart';
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
  Future<Either<String, AuthEntity>> signIn(
      SignInReqParam params) async {
    try {
      final model = await apiService.signIn(params);

      if (!model.success) {
        return Left(model.message);
      }

      await localService.saveToken(model.token);

      return Right(AuthEntity(token: model.token));
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? 'NETWORK_ERROR',
      );
    }
  }

  @override
  Future<Either<String, AuthEntity>> signUp(
      SignUpReqParam params) async {
    try {
      final model = await apiService.signUp(params);

      if (!model.success) {
        return Left(model.message);
      }

      await localService.saveToken(model.token);

      return Right(AuthEntity(token: model.token));
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? 'NETWORK_ERROR',
      );
    }
  }

  @override
  Future<bool> isAuthenticated() {
    return localService.isAuthenticated();
  }
}