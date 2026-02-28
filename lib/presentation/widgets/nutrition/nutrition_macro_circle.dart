import 'package:flutter/material.dart';
import 'package:project_a/presentation/widgets/nutrition/nutrition_macro.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class NutritionMacroCircle extends StatelessWidget {
  const NutritionMacroCircle({super.key, required this.macro});
  final NutritionMacro macro;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 56,
          height: 56,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 52,
                height: 52,
                child: CircularProgressIndicator(
                  value: macro.progress,
                  strokeWidth: 4.5,
                  backgroundColor: ProjectColors.gray.withOpacity(0.3),
                  color: macro.color,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                '${macro.grams}g',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: ProjectSizes.paddingSm),
        Text(
          macro.name,
          style: textTheme.bodySmall?.copyWith(
            color: ProjectColors.textGray,
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
