import 'dart:convert';
import 'package:dio/dio.dart';

class HttpClient {
  static const String _baseURL = 'https://your-api-base-url.com';
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseURL,
      headers: {'Content-Type': 'application/json'},
      sendTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 7),
    ),
  );

  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  static Future<Map<String, dynamic>> post(
    String endpoint,
    dynamic data,
  ) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  static Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  static Map<String, dynamic> _handleResponse(Response response) {
    final status = response.statusCode ?? 0;
    if (status >= 200 && status < 300) {
      final data = response.data;
      if (data is Map<String, dynamic>) return data;
      if (data is String) return json.decode(data) as Map<String, dynamic>;
      return {'data': data};
    } else {
      throw Exception('Failed to load data: $status');
    }
  }

  static Exception _handleDioError(DioException error) {
    if (error.response != null) {
      final status = error.response?.statusCode;
      final data = error.response?.data;
      return Exception('Request failed: $status ${data ?? ''}');
    } else {
      return Exception('Request error: ${error.message}');
    }
  }
}
