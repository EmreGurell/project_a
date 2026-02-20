class ApiEndpoints {
  static const baseUrl = '';

  static String generateUrl(String path){
    return '$baseUrl$path';
  }
  
  static String get register => generateUrl("/register");
  static String get login => generateUrl("/login");
}
