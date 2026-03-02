import 'package:dartz/dartz.dart';
import 'package:project_a/data/models/user/user_form_req_params.dart';
import 'package:project_a/domain/repositories/user/user_repository.dart';

class SubmitUserFormUseCase {
  final UserRepository userRepository;

  SubmitUserFormUseCase({required this.userRepository});

  Future<Either<String, void>> call(UserFormReqParams params) {
    return userRepository.submitUserForm(params);
  }
}
