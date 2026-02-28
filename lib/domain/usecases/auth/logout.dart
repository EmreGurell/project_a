import 'package:dartz/dartz.dart';
import 'package:project_a/core/usecase/usecase.dart';
import 'package:project_a/domain/repositories/auth_repository.dart';

class LogoutUseCase extends Usecase<void, dynamic> {
  final AuthRepository authRepository;

  LogoutUseCase({required this.authRepository});

  @override
  Future<Either<String, void>> call({param}) async {
    return await authRepository.logout();
  }
}