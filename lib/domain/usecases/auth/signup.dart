import 'package:dartz/dartz.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/core/usecase/usecase.dart';
import 'package:project_a/domain/repositories/auth_repository.dart';
import '../../../data/models/auth/signup_req_params.dart';

class SignUpUseCase implements Usecase<Either,SignUpReqParam>{

  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  @override
  Future<Either> call({SignUpReqParam ? param}) async {
    return authRepository.signUp(param!);
  }

}