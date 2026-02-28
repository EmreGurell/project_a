import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:project_a/core/network/api_endpoints.dart';
import 'package:project_a/data/models/cimbil/chat_message_model.dart';
import 'package:project_a/data/models/nutrition/ai_nutrition_result_model.dart';

abstract class AiApiService {
  Stream<String> chatStream(
    List<ChatMessageModel> messages,
    Map<String, String> userContext,
  );
  Future<AiNutritionResultModel> analyzeBarcode(String barcode);
  Future<AiNutritionResultModel> analyzeImage(String imagePath);
}

class AiApiServiceImpl implements AiApiService {
  late final Dio _dio;

  AiApiServiceImpl() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.aiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 120),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  @override
  Stream<String> chatStream(
    List<ChatMessageModel> messages,
    Map<String, String> userContext,
  ) async* {
    final uri = Uri.parse(ApiEndpoints.aiChat);
    final client = HttpClient();
    try {
      final request = await client.postUrl(uri);
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      request.write(jsonEncode({
        'messages': messages.map((m) => m.toJson()).toList(),
        'user_context': userContext,
        'temperature': 0.7,
      }));

      final response = await request.close();
      if (response.statusCode != 200) {
        throw Exception('AI chat error: ${response.statusCode}');
      }

      final lines = response
          .cast<List<int>>()
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      await for (final line in lines) {
        if (!line.startsWith('data: ')) continue;
        final dataStr = line.substring(6).trim();
        if (dataStr == '[DONE]') return;
        try {
          final json = jsonDecode(dataStr) as Map<String, dynamic>;
          final content = json['content'] as String?;
          if (content != null && content.isNotEmpty) yield content;
        } catch (e) {
          debugPrint('SSE parse error: $e — "$line"');
        }
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<AiNutritionResultModel> analyzeBarcode(String barcode) async {
    final response = await _dio.post(
      '/analyze/barcode',
      data: {'barcode': barcode},
    );
    return AiNutritionResultModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<AiNutritionResultModel> analyzeImage(String imagePath) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath),
    });
    final response = await _dio.post(
      '/analyze',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    return AiNutritionResultModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
