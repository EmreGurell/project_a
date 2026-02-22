import 'package:dartz/dartz.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/core/usecase/usecase.dart';
import 'package:project_a/data/models/auth/signin_req_params.dart';
import 'package:project_a/domain/repositories/auth_repository.dart';
import '../../../data/models/auth/signup_req_params.dart';

class SignInUseCase implements Usecase<Either, SignInReqParam> {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});
  @override
  Future<Either> call({SignInReqParam? param}) async {
    return authRepository.signIn(param!);
  }
}
