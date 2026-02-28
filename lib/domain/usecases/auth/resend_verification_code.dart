import 'package:dartz/dartz.dart';
import 'package:project_a/core/usecase/usecase.dart';
import 'package:project_a/data/models/auth/resend_verification_req_params.dart';
import 'package:project_a/domain/repositories/auth_repository.dart';

class ResendVerificationCodeUseCase implements Usecase<Either, ResendVerificationReqParam> {
  final AuthRepository authRepository;

  ResendVerificationCodeUseCase({required this.authRepository});

  @override
  Future<Either> call({ResendVerificationReqParam? param}) {
    return authRepository.resendVerificationCode(param!);
  }
}
