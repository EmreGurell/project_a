import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/data/source/ai/ai_api_service.dart';

import 'nutrition_result_event.dart';
import 'nutrition_result_state.dart';

class NutritionResultBloc
    extends Bloc<NutritionResultEvent, NutritionResultState> {
  final AiApiService _aiService;

  NutritionResultBloc({required AiApiService aiService})
      : _aiService = aiService,
        super(NutritionResultInitial()) {
    on<AnalyzeBarcode>(_onAnalyzeBarcode);
    on<AnalyzeImage>(_onAnalyzeImage);
  }

  Future<void> _onAnalyzeBarcode(
    AnalyzeBarcode event,
    Emitter<NutritionResultState> emit,
  ) async {
    emit(NutritionResultLoading());
    try {
      final result = await _aiService.analyzeBarcode(event.barcode);
      emit(NutritionResultLoaded(result));
    } catch (e) {
      debugPrint('analyzeBarcode error: $e');
      emit(NutritionResultError('Barkod analiz edilemedi. Tekrar deneyin.'));
    }
  }

  Future<void> _onAnalyzeImage(
    AnalyzeImage event,
    Emitter<NutritionResultState> emit,
  ) async {
    emit(NutritionResultLoading());
    try {
      final result = await _aiService.analyzeImage(event.imagePath);
      emit(NutritionResultLoaded(result));
    } catch (e) {
      debugPrint('analyzeImage error: $e');
      emit(NutritionResultError('Fotoğraf analiz edilemedi. Tekrar deneyin.'));
    }
  }
}
