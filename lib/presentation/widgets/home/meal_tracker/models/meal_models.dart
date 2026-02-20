class MealCategory {
  String title;
  int totalCalories;
  String? imageUrl;
  String? imagePath;
  bool isExpanded;
  List<FoodItem> items;

  MealCategory({
    required this.title,
    required this.totalCalories,
    this.imageUrl,
    this.imagePath,
    this.isExpanded = false,
    required this.items,
  });
}

class FoodItem {
  String name;
  int calories;
  int carbs;
  int protein;
  int fat;

  FoodItem({
    required this.name,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
  });
}
