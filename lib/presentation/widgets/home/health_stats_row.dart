import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/themes/custom_themes/text_theme.dart';

class HealthStatsRow extends StatelessWidget {
  const HealthStatsRow({
    super.key,
    this.steps = 7652,
    this.sleepDuration = '6sa 53dk',
    this.heartRateBpm = 94,
    this.showSync = true,
  });

  final int steps;
  final String sleepDuration;
  final int heartRateBpm;
  final bool showSync;

  static const Color _stepsIconColor = Color(0xFFF19C51);
  static const Color _sleepIconColor = Color(0xFFB8A9C9);
  static const Color _heartIconColor = Color(0xFFE57373);

  List<_StatItem> get _statItems => [
    _StatItem(
      icon: PhosphorIconsFill.footprints,
      iconColor: _stepsIconColor,
      value: '$steps',
      label: 'Adım',
    ),
    _StatItem(
      icon: PhosphorIconsFill.moon,
      iconColor: _sleepIconColor,
      value: sleepDuration,
      label: 'Uyku',
    ),
    _StatItem(
      icon: PhosphorIconsFill.heart,
      iconColor: _heartIconColor,
      value: '$heartRateBpm',
      label: 'BPM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _statItems.length,
        itemBuilder: (context, index) {
          final item = _statItems[index];
          return _StatCard(
            icon: item.icon,
            iconColor: item.iconColor,
            value: item.value,
            label: item.label,
            showSync: showSync,
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(width: ProjectSizes.spaceBtwItems),
      ),
    );
  }
}

class _StatItem {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  _StatItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    this.showSync = true,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final bool showSync;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 150,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.pagePadding * 0.75,
          vertical: ProjectSizes.pagePadding,
        ),
        decoration: BoxDecoration(
          color: ProjectColors.cardGray,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(
                      ProjectSizes.borderRadiusMd,
                    ),
                  ),
                  padding: const EdgeInsets.all(ProjectSizes.paddingSm / 2),

                  child: Icon(icon, size: 22, color: iconColor),
                ),
                if (showSync) ...[
                  const SizedBox(width: 6),
                  Text(
                    'sync',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: Theme.of(context).textTheme.title.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: ProjectColors.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
