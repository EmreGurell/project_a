import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/presentation/widgets/home/meal_tracker/models/meal_models.dart';
import 'package:project_a/presentation/widgets/home/meal_tracker/widgets/macro_item.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class FoodDetailCard extends StatelessWidget {
  final FoodItem food;

  const FoodDetailCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: ProjectSizes.spaceBtwSections / 2,
        top: ProjectSizes.spaceBtwItems / 2,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: ProjectSizes.paddingLg,
        vertical: ProjectSizes.paddingMd,
      ),
      decoration: BoxDecoration(
        color: ProjectColors.cardGray,
        borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(food.name, style: Theme.of(context).textTheme.titleMedium),
              IconButton(
                onPressed: () {},
                icon: PhosphorIcon(
                  PhosphorIconsRegular.dotsThreeVertical,
                  size: ProjectSizes.iconM,
                  color: ProjectColors.textGray,
                ),
              ),
            ],
          ),
          SizedBox(height: ProjectSizes.spaceBtwItems / 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MacroItem(
                value: "${food.calories}kcal",
                label: "Calori",
                color: ProjectColors.trackColor,
                target: 2200.0,
                consumed: food.calories.toDouble(),
              ),
              MacroItem(
                value: "${food.carbs}g",
                label: "Karb.",
                color: ProjectColors.carbColor,
                target: 250.0,
                consumed: food.carbs.toDouble(),
              ),
              MacroItem(
                value: "${food.protein}g",
                label: "Protein",
                color: ProjectColors.proteinColor,
                target: 150.0,
                consumed: food.protein.toDouble(),
              ),
              MacroItem(
                value: "${food.fat}g",
                label: "Yağ",
                color: ProjectColors.fatColor,
                target: 65.0,
                consumed: food.fat.toDouble(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
