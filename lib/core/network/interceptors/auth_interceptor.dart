import 'package:dio/dio.dart';

import '../../../data/source/auth/auth_local_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalService localService;

  AuthInterceptor(this.localService);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await localService.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }

    handler.next(options);
  }
}