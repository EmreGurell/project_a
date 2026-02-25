import 'package:flutter/foundation.dart';

class ApiEndpoints {
  static String get baseUrl {
    // Android emulator cannot reach host machine via localhost.
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8080/api/v1/';
    }
    return 'http://localhost:8080/api/';
  }

  static String generateUrl(String path) {
    return '$baseUrl$path';
  }

  static String get register => generateUrl("users/register");
  static String get login => generateUrl("users/login");
  static String get currentUser => generateUrl("users/me");
  static String get nutritionDataByDate => generateUrl("nutrition/get-by-date");
}
