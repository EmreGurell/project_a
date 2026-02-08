import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.directions_walk_rounded,
            iconColor: _stepsIconColor,
            value: '$steps',
            label: 'Adım',
            showSync: showSync,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.nightlight_round,
            iconColor: _sleepIconColor,
            value: sleepDuration,
            label: 'Uyku',
            showSync: showSync,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.favorite_rounded,
            iconColor: _heartIconColor,
            value: '$heartRateBpm',
            label: 'BPM',
            showSync: showSync,
          ),
        ),
      ],
    );
  }
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

  static const Color _cardBackground = Color(0xFFF7F7F7);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ProjectColors.gray.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: iconColor),
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
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
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
    );
  }
}
