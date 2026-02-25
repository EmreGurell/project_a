import 'package:flutter/foundation.dart';

class ApiEndpoints {
  static String get baseUrl {
    // Android emulator cannot reach host machine via localhost.
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8081/';
    }
    return 'http://localhost:8081/';
  }

  static String generateUrl(String path) {
    return '$baseUrl$path';
  }

  //Posts
  static String get register => generateUrl("api/v1/users/register");
  static String get login => generateUrl("api/v1/users/login");

  //Gets
  static String get me => generateUrl("api/v1/users/me");
}
