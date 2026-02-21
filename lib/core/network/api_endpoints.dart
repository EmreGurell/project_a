class ApiEndpoints {
  static const baseUrl = 'http://10.0.2.2:8080/api/';

  static String generateUrl(String path){
    return '$baseUrl$path';
  }
  
  static String get register => generateUrl("users/register");
  static String get login => generateUrl("users/login");
}
