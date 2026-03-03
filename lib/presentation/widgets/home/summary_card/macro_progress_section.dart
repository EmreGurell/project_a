import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class MacroProgressSection extends StatelessWidget {
  const MacroProgressSection({
    super.key,
    required this.carbProgress,
    required this.proteinProgress,
    required this.fatProgress,
  });

  final double carbProgress;
  final double proteinProgress;
  final double fatProgress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _MacroBar(
          label: l10n.nutrition_carb,
          progress: carbProgress,
          color: ProjectColors.carbColor,
        ),
        const SizedBox(height: ProjectSizes.spaceBtwItems), // Çubuklar arası boşluk
        _MacroBar(
          label: l10n.nutrition_protein,
          progress: proteinProgress,
          color: ProjectColors.proteinColor,
        ),
        const SizedBox(height: ProjectSizes.spaceBtwItems),
        _MacroBar(
          label: l10n.nutrition_fat,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 40,
          child: Text(
            label,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        const SizedBox(width: ProjectSizes.spaceBtwItems / 2),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return LinearPercentIndicator(
                width: constraints.maxWidth,
                lineHeight: 12,
                percent: progress.clamp(0.0, 1.0),
                backgroundColor: ProjectColors.cardGray,
                progressColor: color,
                barRadius: const Radius.circular(ProjectSizes.borderRadiusLg),
                padding: EdgeInsets.zero,
                animation: false,
              );
            },
          ),
        ),
      ],
    );
  }
}