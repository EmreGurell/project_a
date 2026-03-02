class NutritionLogReqParams {
  final String foodName;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double? fiber;
  final String mealType;
  final DateTime date;

  NutritionLogReqParams({
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.fiber,
    required this.mealType,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'foodName': foodName,
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
        if (fiber != null) 'fiber': fiber,
        'mealType': mealType,
        'date': '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
        'source': 'manual',
      };
}
