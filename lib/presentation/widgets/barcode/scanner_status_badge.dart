import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/sizes.dart';

class ScannerStatusBadge extends StatelessWidget {
  const ScannerStatusBadge({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ProjectSizes.paddingMd - 2,
        vertical: ProjectSizes.paddingSm - 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(ProjectSizes.pagePadding),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: ProjectSizes.iconSm),
          const SizedBox(width: ProjectSizes.paddingSm - 2),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
