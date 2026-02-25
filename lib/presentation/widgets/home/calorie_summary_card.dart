import 'package:flutter/material.dart';
import 'package:project_a/domain/entities/nutrition/nutrition_entity.dart';
import 'package:project_a/presentation/widgets/home/summary_card/calorie_circle_section.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'summary_card/macro_progress_section.dart';

class CalorieSummaryCard extends StatelessWidget {
  final NutritionEntity? nutrition;

  const CalorieSummaryCard({
    super.key,
    this.nutrition,
  });

  @override
  Widget build(BuildContext context) {
    const double targetCalories = 2500;
    const double targetCarbs = 300;
    const double targetProtein = 150;
    const double targetFat = 80;


    final double calorieProgress = (nutrition?.totalCalories ?? 0) / targetCalories;
    final double carbProgress = (nutrition?.carbs ?? 0) / targetCarbs;
    final double proteinProgress = (nutrition?.protein ?? 0) / targetProtein;
    final double fatProgress = (nutrition?.fat ?? 0) / targetFat;

    return Container(
      padding: const EdgeInsets.all(ProjectSizes.pagePadding),
      decoration: BoxDecoration(
        color: ProjectColors.mainCardBlue,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(ProjectSizes.imageAndCardRadius * 2),
          bottomRight: Radius.circular(ProjectSizes.imageAndCardRadius * 2),
        ),
        border: Border.all(
          color: ProjectColors.secondaryCardBlue.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.spaceBtwItems / 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MacroProgressSection(
              carbProgress: carbProgress.clamp(0.0, 1.0),
              proteinProgress: proteinProgress.clamp(0.0, 1.0),
              fatProgress: fatProgress.clamp(0.0, 1.0),
            ),
            CalorieCircleSection(
              calories: nutrition?.totalCalories.toInt() ?? 0,
              progress: calorieProgress.clamp(0.0, 1.0),
            ),
          ],
        ),
      ),
    );
  }
}