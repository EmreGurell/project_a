import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_a/data/source/user/user_api_service.dart';
import 'package:project_a/domain/entities/user/user_entity.dart';
import 'package:project_a/domain/repositories/user/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApiService apiService;

  UserRepositoryImpl({required this.apiService});

  @override
  Future<Either<String,UserEntity>> getCurrentUser() async{
    try{
      final model = await apiService.getCurrentUser();
      return Right(model.toEntity());
    } on DioException catch(e){
      return Left(e.response?.data['message'] ?? "NETWORK ERROR");
    }
  }


}