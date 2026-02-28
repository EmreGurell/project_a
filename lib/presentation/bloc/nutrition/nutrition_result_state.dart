import 'package:project_a/data/models/nutrition/ai_nutrition_result_model.dart';

abstract class NutritionResultState {}

class NutritionResultInitial extends NutritionResultState {}

class NutritionResultLoading extends NutritionResultState {}

class NutritionResultLoaded extends NutritionResultState {
  final AiNutritionResultModel result;
  NutritionResultLoaded(this.result);
}

class NutritionResultError extends NutritionResultState {
  final String message;
  NutritionResultError(this.message);
}
