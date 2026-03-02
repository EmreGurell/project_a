import 'package:dartz/dartz.dart';
import 'package:project_a/domain/entities/user/user_metrics_entity.dart';
import 'package:project_a/domain/repositories/user/user_repository.dart';

class GetUserMetricsUseCase {
  final UserRepository userRepository;

  GetUserMetricsUseCase({required this.userRepository});

  Future<Either<String, UserMetricsEntity>> call() {
    return userRepository.getUserMetrics();
  }
}
