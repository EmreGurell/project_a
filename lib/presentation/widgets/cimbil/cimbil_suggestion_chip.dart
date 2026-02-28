import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class CimbilSuggestionChip extends StatelessWidget {
  const CimbilSuggestionChip({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.paddingMd,
          vertical: ProjectSizes.paddingSm,
        ),
        decoration: BoxDecoration(
          color: ProjectColors.cardGray,
          borderRadius: BorderRadius.circular(ProjectSizes.pagePadding),
          border: Border.all(color: ProjectColors.gray.withOpacity(0.4)),
        ),
        child: Text(
          label,
          style: textTheme.bodySmall?.copyWith(color: Colors.black87),
        ),
      ),
    );
  }
}
