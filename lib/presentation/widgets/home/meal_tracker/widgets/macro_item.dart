import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class MacroItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final double target;
  final double consumed;

  const MacroItem({
    super.key,
    required this.value,
    required this.label,
    required this.color,
    required this.target,
    required this.consumed,
  });

  @override
  Widget build(BuildContext context) {
    final barWidth = 12.0;
    final barHeight = 60.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Dikey Bar
        Container(
          height: barHeight,
          width: barWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusMd),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: barHeight * consumed / target,
              width: barWidth,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(
                  ProjectSizes.borderRadiusMd,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: ProjectSizes.spaceBtwItems / 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: Theme.of(context).textTheme.titleMedium),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: ProjectColors.textGray),
            ),
          ],
        ),
      ],
    );
  }
}
