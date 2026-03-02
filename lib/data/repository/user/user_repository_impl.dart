import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_a/data/models/user/user_form_req_params.dart';
import 'package:project_a/data/source/user/user_api_service.dart';
import 'package:project_a/domain/entities/user/user_entity.dart';
import 'package:project_a/domain/entities/user/user_metrics_entity.dart';
import 'package:project_a/domain/repositories/user/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApiService apiService;

  UserRepositoryImpl({required this.apiService});

  @override
  Future<Either<String, UserEntity>> getCurrentUser() async {
    try {
      final model = await apiService.getCurrentUser();
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(_errorCode(e));
    }
  }

  @override
  Future<Either<String, void>> submitUserForm(UserFormReqParams params) async {
    try {
      await apiService.submitUserForm(params);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_errorCode(e));
    }
  }

  @override
  Future<Either<String, UserMetricsEntity>> getUserMetrics() async {
    try {
      final model = await apiService.getUserMetrics();
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(_errorCode(e));
    }
  }

  static String _errorCode(DioException e) {
    if (e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionTimeout) {
      return 'TIMEOUT';
    }
    final data = e.response?.data;
    if (data is Map) {
      return (data['code'] ?? data['message'] ?? 'NETWORK_ERROR').toString();
    }
    return 'NETWORK_ERROR';
  }
}