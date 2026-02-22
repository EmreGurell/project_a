import 'package:flutter/material.dart';
import 'package:project_a/presentation/widgets/home/meal_tracker/models/meal_models.dart';
import 'package:project_a/presentation/widgets/home/meal_tracker/widgets/meal_header.dart';
import 'package:project_a/presentation/widgets/home/meal_tracker/widgets/food_detail_card.dart';

class MealSection extends StatelessWidget {
  final MealCategory meal;
  final VoidCallback onToggle;

  const MealSection({super.key, required this.meal, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MealHeader(
          imageUrl: meal.imageUrl,
          imagePath: meal.imagePath,
          title: meal.title,
          totalCalories: meal.totalCalories,
          isExpanded: meal.isExpanded,
          onTap: onToggle,
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Column(
            children: meal.items
                .map((food) => FoodDetailCard(food: food))
                .toList(),
          ),
          crossFadeState: meal.isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}
