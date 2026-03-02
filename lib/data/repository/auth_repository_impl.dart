import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_a/data/source/auth/auth_api_service.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth/forgot_password_req_params.dart';
import '../models/auth/resend_verification_req_params.dart';
import '../models/auth/reset_password_req_params.dart';
import '../models/auth/signin_req_params.dart';
import '../models/auth/signup_req_params.dart';
import '../models/auth/verify_account_req_params.dart';
import '../source/auth/auth_local_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService apiService;
  final AuthLocalService localService;

  AuthRepositoryImpl({required this.apiService, required this.localService});

  @override
  Future<Either<String, AuthEntity>> signIn(SignInReqParam params) async {
    try {
      final model = await apiService.signIn(params);

      if (!model.success) {
        return Left(model.message);
      }

      await localService.saveToken(model.token);

      return Right(AuthEntity(
        token: model.token,
        id: model.loginUserId ?? '',
        email: model.loginUserEmail ?? '',
        firstName: model.loginUserFirstName ?? '',
        lastName: model.loginUserLastName ?? '',
        username: model.loginUsername,
        hasProfile: model.hasProfile ?? false,
      ));
    } on DioException catch (e) {
      return Left(_errorCode(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> signUp(SignUpReqParam params) async {
    try {
      final model = await apiService.signUp(params);

      if (!model.success) {
        return Left(model.message);
      }

      return Right(model.userId);
    } on DioException catch (e) {
      return Left(_errorCode(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<bool> isAuthenticated() {
    return localService.isAuthenticated();
  }

  @override
  Future<Either<String, void>> logout() async {
    try {
      await localService.clearToken();
      return const Right(null);
    } catch (e) {
      return Left('Çıkış yapılırken bir hata oluştu: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> forgotPassword(
    ForgotPasswordReqParam param,
  ) async {
    try {
      final model = await apiService.forgotPassword(param);
      if (!model.success) return Left(model.message);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_errorCode(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> resetPassword(
    ResetPasswordReqParam param,
  ) async {
    try {
      final model = await apiService.resetPassword(param);
      if (!model.success) return Left(model.message);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_errorCode(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> verifyAccount(
    VerifyAccountReqParam param,
  ) async {
    try {
      final model = await apiService.verifyAccount(param);
      if (!model.success) return Left(model.message);
      if (model.token.isNotEmpty) {
        await localService.saveToken(model.token);
      }
      return const Right(null);
    } on DioException catch (e) {
      return Left(_errorCode(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> resendVerificationCode(
    ResendVerificationReqParam param,
  ) async {
    try {
      final model = await apiService.resendVerificationCode(param);
      if (!model.success) return Left(model.message);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_errorCode(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Backend hata response'undan önce `code`, yoksa `message` alır.
  /// Timeout durumlarını özel olarak yakalar.
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
