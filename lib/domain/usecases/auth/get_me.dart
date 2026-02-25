import 'package:dartz/dartz.dart';
import 'package:project_a/core/usecase/usecase.dart';
import 'package:project_a/domain/repositories/auth_repository.dart';

class GetMeUseCase implements Usecase<Either, dynamic> {
  final AuthRepository authRepository;
  GetMeUseCase({required this.authRepository});
  @override
  Future<Either> call({dynamic param}) async {
    return authRepository.getMe();
  }
}
