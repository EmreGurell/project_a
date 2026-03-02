class ApiEndpoints {
  // AI Service (Local Docker)
  static const String aiBaseUrl = 'http://10.0.2.2';
  static String get aiChat => '${aiBaseUrl}:8000/api/chat';
  static String get aiAnalyzeText => '${aiBaseUrl}:5000/analyze/text';
  static String get aiAnalyzeBarcode => '${aiBaseUrl}:5000/analyze/barcode';
  static String get aiAnalyzeBarcodeImage =>
      '${aiBaseUrl}:5000/analyze/barcode_image';
  static String get aiAnalyzeImage => '${aiBaseUrl}:5000/analyze';

  // Main Backend
  static const String _productionUrl =
      'https://api-gateway-production-fd99.up.railway.app';

  static String get baseUrl {
    // Local dev için yorum satırını aç:
    // if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) return 'http://10.0.2.2:8080';
    // return 'http://localhost:8080';
    return _productionUrl;
  }

  static String generateUrl(String path) {
    return '$baseUrl/$path';
  }

  static String get register => generateUrl("api/v1/auth/register");
  static String get login => generateUrl("api/v1/auth/login");
  static String get currentUser => generateUrl("api/v1/users/me");
  static String get nutritionDataByDate =>
      generateUrl("api/v1/nutrition/get-by-date");

  // Auth - Forgot / Reset Password
  static String get forgotPassword =>
      generateUrl("api/v1/auth/forgot-password");
  static String get resetPassword => generateUrl("api/v1/auth/reset-password");

  // Auth - Account Verification
  static String get verifyAccount => generateUrl("api/v1/auth/verify-email");
  static String get resendVerification =>
      generateUrl("api/v1/auth/resend-code");

  // User Profile (FRONTEND.md)
  static String get userProfile => generateUrl("api/v1/users/profile");

  // Nutrition
  static String get nutritionLog => generateUrl("api/v1/nutrition/log");
}
