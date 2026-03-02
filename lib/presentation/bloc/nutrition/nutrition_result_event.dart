import 'package:project_a/data/models/nutrition/ai_nutrition_result_model.dart';

abstract class NutritionResultEvent {}

class AnalyzeBarcode extends NutritionResultEvent {
  final String barcode;
  AnalyzeBarcode(this.barcode);
}

class AnalyzeImage extends NutritionResultEvent {
  final String imagePath;
  AnalyzeImage(this.imagePath);
}

class LogNutrition extends NutritionResultEvent {
  final AiNutritionResultModel result;
  final String mealType;
  LogNutrition({required this.result, required this.mealType});
}
