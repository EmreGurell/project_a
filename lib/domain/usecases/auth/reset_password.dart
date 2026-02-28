import 'package:dartz/dartz.dart';
import 'package:project_a/core/usecase/usecase.dart';
import 'package:project_a/data/models/auth/reset_password_req_params.dart';
import 'package:project_a/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase implements Usecase<Either, ResetPasswordReqParam> {
  final AuthRepository authRepository;

  ResetPasswordUseCase({required this.authRepository});

  @override
  Future<Either> call({ResetPasswordReqParam? param}) {
    return authRepository.resetPassword(param!);
  }
}
