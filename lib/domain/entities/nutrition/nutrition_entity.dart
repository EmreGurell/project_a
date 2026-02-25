class NutritionEntity {
  final int id;
  final double totalCalories;
  final double protein;
  final double carbs;
  final double fat;
  final DateTime date;

  NutritionEntity({
    required this.id,
    required this.totalCalories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.date,
  });
}