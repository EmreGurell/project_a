import 'package:flutter/material.dart';
import 'package:project_a/presentation/widgets/home/summary_card/animated_semi_circle_progress.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/l10n/app_localizations.dart';

class CalorieCircleSection extends StatelessWidget {
  const CalorieCircleSection({
    super.key,
    required this.calories,
    required this.progress,
  });

  final int calories;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        AnimatedSemiCircleProgress(
          progress: progress,
          color: ProjectColors.yellow,
          backgroundColor: ProjectColors.white,
          size: 140,
          strokeWidth: 10,
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: ProjectColors.yellow,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Icon(
              Icons.graphic_eq_rounded,
              size: ProjectSizes.iconM,
              color: Colors.black87,
            ),
          ),
          center: _CalorieCenter(calories: calories),
        ),
      ],
    );
  }
}

class _CalorieCenter extends StatelessWidget {
  const _CalorieCenter({required this.calories});
  final int calories;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.55),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 92,
        height: 92,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$calories', style: Theme.of(context).textTheme.titleLarge),
            Text(
              AppLocalizations.of(context)!.home_calorie,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
