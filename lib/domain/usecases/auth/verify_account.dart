import 'package:dartz/dartz.dart';
import 'package:project_a/core/usecase/usecase.dart';
import 'package:project_a/data/models/auth/verify_account_req_params.dart';
import 'package:project_a/domain/repositories/auth_repository.dart';

class VerifyAccountUseCase implements Usecase<Either, VerifyAccountReqParam> {
  final AuthRepository authRepository;

  VerifyAccountUseCase({required this.authRepository});

  @override
  Future<Either> call({VerifyAccountReqParam? param}) {
    return authRepository.verifyAccount(param!);
  }
}
