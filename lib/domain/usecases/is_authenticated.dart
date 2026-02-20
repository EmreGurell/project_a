import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/core/usecase/usecase.dart';
import 'package:project_a/domain/repositories/auth_repository.dart';

class IsAuthenticatedUseCase implements Usecase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async {
    return await sl<AuthRepository>().isAuthenticated();
  }
}
