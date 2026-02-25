import 'package:project_a/data/models/user/user_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';

abstract class UserApiService {
  Future<UserModel> getCurrentUser();
}

class UserApiServiceImpl extends UserApiService {

  final DioClient dioClient;

  UserApiServiceImpl({required this.dioClient});

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await dioClient.get(ApiEndpoints.currentUser);
    return UserModel.fromJson(response.data['data']);
  }

}