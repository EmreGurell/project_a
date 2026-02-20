import 'package:flutter/material.dart';
import 'package:project_a/presentation/widgets/home/meal_tracker/models/meal_models.dart';
import 'package:project_a/presentation/widgets/home/meal_tracker/widgets/meal_section.dart';

class MealTrackerScreen extends StatefulWidget {
  const MealTrackerScreen({super.key});

  @override
  State<MealTrackerScreen> createState() => _MealTrackerScreenState();
}

class _MealTrackerScreenState extends State<MealTrackerScreen> {
  List<MealCategory> meals = [
    MealCategory(
      title: "Kahvaltı",
      totalCalories: 652,
      isExpanded: true,
      items: [
        FoodItem(
          name: "Nutella Krep",
          calories: 652,
          carbs: 72,
          protein: 35,
          fat: 18,
        ),
      ],
    ),
    MealCategory(
      title: "Öğle Yemeği",
      totalCalories: 350,
      isExpanded: false,
      items: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: meals.asMap().entries.map((entry) {
        final index = entry.key;
        final meal = entry.value;
        return MealSection(
          meal: meal,
          onToggle: () {
            setState(() {
              meals[index].isExpanded = !meals[index].isExpanded;
            });
          },
        );
      }).toList(),
    );
  }
}
