import 'package:dartz/dartz.dart';

import '../../entities/user/user_entity.dart';
import '../../entities/user/user_metrics_entity.dart';
import '../../../data/models/user/user_form_req_params.dart';

abstract class UserRepository {
  Future<Either<String, UserEntity>> getCurrentUser();
  Future<Either<String, void>> submitUserForm(UserFormReqParams params);
  Future<Either<String, UserMetricsEntity>> getUserMetrics();
}