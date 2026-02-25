import '../../../domain/entities/nutrition/nutrition_entity.dart';

class NutritionModel extends NutritionEntity {
NutritionModel({
  required super.id,
  required super.totalCalories,
  required super.protein,
  required super.carbs,
  required super.fat,
  required super.date,
});

factory NutritionModel.fromJson(Map<String, dynamic> json) {
return NutritionModel(
id: json['id'] ?? 0,
totalCalories: (json['totalCalories'] ?? 0).toDouble(),
protein: (json['protein'] ?? 0).toDouble(),
carbs: (json['carbs'] ?? 0).toDouble(),
fat: (json['fat'] ?? 0).toDouble(),
date: DateTime.parse(json['date']),
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
);
}
}