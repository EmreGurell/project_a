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

class NutritionLogLoading extends NutritionResultState {
  final AiNutritionResultModel result;
  NutritionLogLoading(this.result);
}

class NutritionLogSuccess extends NutritionResultState {}

class NutritionLogError extends NutritionResultState {
  final AiNutritionResultModel result;
  final String message;
  NutritionLogError({required this.result, required this.message});
}
