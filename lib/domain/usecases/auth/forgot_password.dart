import 'package:dartz/dartz.dart';
import 'package:project_a/core/usecase/usecase.dart';
import 'package:project_a/data/models/auth/forgot_password_req_params.dart';
import 'package:project_a/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase implements Usecase<Either, ForgotPasswordReqParam> {
  final AuthRepository authRepository;

  ForgotPasswordUseCase({required this.authRepository});

  @override
  Future<Either> call({ForgotPasswordReqParam? param}) {
    return authRepository.forgotPassword(param!);
  }
}
