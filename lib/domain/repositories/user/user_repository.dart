import 'package:dartz/dartz.dart';

import '../../entities/user/user_entity.dart';

abstract class UserRepository {
  Future<Either<String, UserEntity>> getCurrentUser();
}