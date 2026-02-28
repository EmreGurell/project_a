import 'package:project_a/utils/local_storage/storage_service.dart';

abstract class AuthLocalService{
  Future<void> saveToken(String token);
  Future<bool> isAuthenticated();
  Future<String?> getToken();
  Future<void> clearToken();
}

class AuthLocalServiceImpl extends AuthLocalService {
  final LocalStorageService storageService;

  AuthLocalServiceImpl({required this.storageService});

  @override
  Future<void> saveToken(String token) async {
    await storageService.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return await storageService.getToken();
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await storageService.getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> clearToken() async {
    await storageService.clearToken();
  }
}