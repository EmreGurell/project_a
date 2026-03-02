import 'package:project_a/data/models/user/user_form_req_params.dart';
import 'package:project_a/data/models/user/user_metrics_model.dart';
import 'package:project_a/data/models/user/user_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';

abstract class UserApiService {
  Future<UserModel> getCurrentUser();
  Future<void> submitUserForm(UserFormReqParams params);
  Future<UserMetricsModel> getUserMetrics();
}

class UserApiServiceImpl extends UserApiService {
  final DioClient dioClient;

  UserApiServiceImpl({required this.dioClient});

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await dioClient.get(ApiEndpoints.currentUser);
    return UserModel.fromJson(response.data['data']);
  }

  @override
  Future<void> submitUserForm(UserFormReqParams params) async {
    await dioClient.post(ApiEndpoints.userProfile, data: params.toJson());
  }

  @override
  Future<UserMetricsModel> getUserMetrics() async {
    final response = await dioClient.get(ApiEndpoints.currentUser);
    final data = response.data['data'] as Map<String, dynamic>;
    final profile = data['profile'] as Map<String, dynamic>?;
    if (profile == null) throw Exception('Profil bulunamadı');
    final streakData = data['streakData'] as Map<String, dynamic>?;
    return UserMetricsModel.fromJson(profile, streakData: streakData);
  }
}
