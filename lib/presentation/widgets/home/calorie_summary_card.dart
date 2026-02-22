import 'package:flutter/material.dart';
import 'package:project_a/presentation/widgets/home/summary_card/calorie_circle_section.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'summary_card/macro_progress_section.dart';

class CalorieSummaryCard extends StatelessWidget {
  const CalorieSummaryCard({
    super.key,
    this.calories = 2400,
    this.calorieProgress = .2,
    this.carbProgress = 0.72,
    this.proteinProgress = 0.58,
    this.fatProgress = 0.38,
  });

  final int calories;
  final double calorieProgress;
  final double carbProgress;
  final double proteinProgress;
  final double fatProgress;

  @override
  Widget build(BuildContext context) {
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
              carbProgress: carbProgress,
              proteinProgress: proteinProgress,
              fatProgress: fatProgress,
            ),
            CalorieCircleSection(calories: calories, progress: calorieProgress),
          ],
        ),
      ),
    );
  }
}
