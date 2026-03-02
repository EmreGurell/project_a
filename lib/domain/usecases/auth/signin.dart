import 'package:dartz/dartz.dart';
import 'package:project_a/core/usecase/usecase.dart';
import 'package:project_a/data/models/auth/signin_req_params.dart';
import 'package:project_a/domain/entities/auth_entity.dart';
import 'package:project_a/domain/repositories/auth_repository.dart';

class SignInUseCase implements Usecase<Either<String, AuthEntity>, SignInReqParam> {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});
  @override
  Future<Either<String, AuthEntity>> call({SignInReqParam? param}) async {
    return authRepository.signIn(param!);
  }
}
