import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class MacroProgressSection extends StatelessWidget {
  const MacroProgressSection({
    required this.carbProgress,
    required this.proteinProgress,
    required this.fatProgress,
  });

  final double carbProgress;
  final double proteinProgress;
  final double fatProgress;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        _MacroBar(
          label: 'Karbonhidrat',
          progress: carbProgress,
          color: ProjectColors.carbColor,
        ),
        _MacroBar(
          label: 'Protein',
          progress: proteinProgress,
          color: ProjectColors.proteinColor,
        ),
        _MacroBar(
          label: 'Yağ',
          progress: fatProgress,
          color: ProjectColors.fatColor,
        ),
      ],
    );
  }
}

class _MacroBar extends StatelessWidget {
  const _MacroBar({
    required this.label,
    required this.progress,
    required this.color,
  });

  final String label;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RotatedBox(
          quarterTurns: -1,
          child: LinearPercentIndicator(
            width: 100,
            lineHeight: 20,
            percent: progress.clamp(0.0, 1.0),
            backgroundColor: ProjectColors.cardGray,
            progressColor: color,
            barRadius: const Radius.circular(ProjectSizes.borderRadiusLg),
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
        SizedBox(
          width: 50,
          child: Text(
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
