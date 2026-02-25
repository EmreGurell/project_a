import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    this.icon,
    required this.title,
    required this.value,
    this.subtitle,
    this.subtitleColor,
    this.progress,
    this.width = 128,
  });

  final IconData? icon;
  final String title;
  final String value;
  final String? subtitle;
  final Color? subtitleColor;
  final double? progress;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.paddingMd,
          vertical: ProjectSizes.paddingMd,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null)
                  Icon(icon, size: ProjectSizes.iconM, color: Colors.grey[700]),
                const SizedBox(width: ProjectSizes.paddingSm),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ProjectSizes.paddingSm),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: 12,
                  color: subtitleColor ?? Colors.grey,
                ),
              ),
            ],
            if (progress != null) ...[
              const SizedBox(height: ProjectSizes.paddingMd),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress!.clamp(0.0, 1.0),
                  minHeight: 6,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation(
                    ProjectColors.leaderboardGreen,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
