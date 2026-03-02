import '../../../domain/entities/nutrition/nutrition_entity.dart';

class NutritionModel extends NutritionEntity {
  NutritionModel({
    required super.id,
    required super.totalCalories,
    required super.protein,
    required super.carbs,
    required super.fat,
    required super.date,
    super.dailyGoal,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json) {
    // FRONTEND.md format: { totals: { calories, protein, carbs, fat }, dailyGoal, date }
    // Fallback to flat format for backwards compatibility
    final totals = json['totals'] as Map<String, dynamic>?;
    return NutritionModel(
      id: json['id'] ?? 0,
      totalCalories: (totals?['calories'] ?? json['totalCalories'] ?? 0).toDouble(),
      protein: (totals?['protein'] ?? json['protein'] ?? 0).toDouble(),
      carbs: (totals?['carbs'] ?? json['carbs'] ?? 0).toDouble(),
      fat: (totals?['fat'] ?? json['fat'] ?? 0).toDouble(),
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      dailyGoal: (json['dailyGoal'] ?? 0).toDouble(),
    );
  }

  NutritionEntity toEntity() {
    return NutritionEntity(
      id: id,
      totalCalories: totalCalories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      date: date,
      dailyGoal: dailyGoal,
    );
  }
}