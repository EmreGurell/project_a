import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/data/models/nutrition/nutrition_log_req_params.dart';
import 'package:project_a/data/source/ai/ai_api_service.dart';
import 'package:project_a/domain/usecases/nutrition/log_nutrition.dart';

import 'nutrition_result_event.dart';
import 'nutrition_result_state.dart';

class NutritionResultBloc
    extends Bloc<NutritionResultEvent, NutritionResultState> {
  final AiApiService _aiService;
  final LogNutritionUseCase _logNutritionUseCase;

  NutritionResultBloc({
    required AiApiService aiService,
    required LogNutritionUseCase logNutritionUseCase,
  })  : _aiService = aiService,
        _logNutritionUseCase = logNutritionUseCase,
        super(NutritionResultInitial()) {
    on<AnalyzeBarcode>(_onAnalyzeBarcode);
    on<AnalyzeImage>(_onAnalyzeImage);
    on<LogNutrition>(_onLogNutrition);
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

  Future<void> _onLogNutrition(
    LogNutrition event,
    Emitter<NutritionResultState> emit,
  ) async {
    emit(NutritionLogLoading(event.result));
    final result = await _logNutritionUseCase.call(
      param: NutritionLogReqParams(
        foodName: event.result.name,
        calories: event.result.calories,
        protein: event.result.protein,
        carbs: event.result.carbs,
        fat: event.result.fat,
        fiber: event.result.fiber,
        mealType: event.mealType,
      ),
    );
    result.fold(
      (error) => emit(NutritionLogError(result: event.result, message: error)),
      (_) => emit(NutritionLogSuccess()),
    );
  }
}
