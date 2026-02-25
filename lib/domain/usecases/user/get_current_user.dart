import 'package:dartz/dartz.dart';
import 'package:project_a/core/usecase/usecase.dart';
import 'package:project_a/domain/repositories/user/user_repository.dart';

class GetCurrentUserUseCase extends Usecase<Either,dynamic>{
  final UserRepository userRepository;

  GetCurrentUserUseCase({required this.userRepository});

  @override
  Future<Either> call({dynamic param}) async{
   return await userRepository.getCurrentUser();
  }


}