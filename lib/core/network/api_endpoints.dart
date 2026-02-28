import 'package:flutter/foundation.dart';

class ApiEndpoints {
  // AI Service (Railway)
  static const String aiBaseUrl =
      'https://skillful-perfection-production.up.railway.app';
  static String get aiChat => 'https://cimbil-ai.sexual-vernice.internal/api/chat';
  static String get aiAnalyzeText => '$aiBaseUrl/analyze/text';
  static String get aiAnalyzeBarcode => '$aiBaseUrl/analyze/barcode';
  static String get aiAnalyzeBarcodeImage => '$aiBaseUrl/analyze/barcode_image';
  static String get aiAnalyzeImage => '$aiBaseUrl/analyze';

  // Main Backend
  static String get baseUrl {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'https://unbrushed-unbarrenly-maryrose.ngrok-free.dev';
    }
    return 'http://localhost:8080';
  }

  static String generateUrl(String path) {
    return '$baseUrl/$path';
  }

  static String get register => generateUrl("api/v1/users/register");
  static String get login => generateUrl("api/v1/users/login");
  static String get currentUser => generateUrl("api/v1/users/me");
  static String get nutritionDataByDate =>
      generateUrl("api/v1/nutrition/get-by-date");

  // Auth - Forgot / Reset Password
  static String get forgotPassword =>
      generateUrl("api/v1/users/forgot-password");
  static String get resetPassword => generateUrl("api/v1/users/reset-password");

  // Auth - Account Verification
  static String get verifyAccount => generateUrl("api/v1/users/verify");
  static String get resendVerification =>
      generateUrl("api/v1/users/resend-verification");
}
