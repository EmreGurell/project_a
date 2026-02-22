import 'package:flutter/foundation.dart';

class ApiEndpoints {
  static String get baseUrl {
    // Android emulator cannot reach host machine via localhost.
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3000/';
    }
    return 'http://localhost:3000/';
  }

  static String generateUrl(String path) {
    return '$baseUrl$path';
  }

  static String get register => generateUrl("users/register");
  static String get login => generateUrl("users/login");
}
