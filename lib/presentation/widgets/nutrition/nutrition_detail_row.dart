import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class NutritionDetailRow extends StatelessWidget {
  const NutritionDetailRow({
    super.key,
    required this.label,
    required this.value,
    required this.percent,
    required this.color,
  });

  final String label;
  final String value;
  final double percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: ProjectSizes.paddingSm,
          height: ProjectSizes.paddingSm,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: ProjectSizes.paddingSm),
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusSm),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: ProjectSizes.paddingSm,
              backgroundColor: ProjectColors.gray.withOpacity(0.3),
              color: color,
            ),
          ),
        ),
        const SizedBox(width: ProjectSizes.paddingSm),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
