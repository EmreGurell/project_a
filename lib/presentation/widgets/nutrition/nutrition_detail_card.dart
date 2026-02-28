import 'package:flutter/material.dart';
import 'package:project_a/presentation/widgets/nutrition/nutrition_detail_row.dart';
import 'package:project_a/presentation/widgets/nutrition/nutrition_macro.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class NutritionDetailCard extends StatelessWidget {
  const NutritionDetailCard({super.key, required this.macros});
  final List<NutritionMacro> macros;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ProjectSizes.pagePadding),
      padding: const EdgeInsets.all(ProjectSizes.pagePadding),
      decoration: BoxDecoration(
        color: ProjectColors.cardGray,
        borderRadius: BorderRadius.circular(ProjectSizes.pagePadding),
      ),
      child: Column(
        children: [
          for (int i = 0; i < macros.length; i++) ...[
            if (i > 0) const SizedBox(height: ProjectSizes.spaceBtwItems - 2),
            NutritionDetailRow(
              label: macros[i].name,
              value: '${macros[i].grams}g',
              percent: macros[i].progress,
              color: macros[i].color,
            ),
          ],
        ],
      ),
    );
  }
}
