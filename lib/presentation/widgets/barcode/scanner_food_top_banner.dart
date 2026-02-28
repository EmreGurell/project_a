import 'package:flutter/material.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/utils/constants/sizes.dart';

class ScannerFoodTopBanner extends StatelessWidget {
  const ScannerFoodTopBanner({
    super.key,
    required this.visible,
    required this.onDismiss,
  });

  final bool visible;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Positioned(
      top: MediaQuery.of(context).padding.top + 52,
      left: ProjectSizes.paddingMd,
      right: ProjectSizes.paddingMd,
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: IgnorePointer(
          ignoring: !visible,
          child: GestureDetector(
            onTap: onDismiss,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: ProjectSizes.paddingMd - 2,
                vertical: ProjectSizes.paddingSm + 4,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF009688).withOpacity(0.92),
                borderRadius: BorderRadius.circular(ProjectSizes.paddingMd - 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.scanner_food_instruction,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.95),
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: ProjectSizes.paddingSm),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white.withOpacity(0.9),
                      size: ProjectSizes.iconSm,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
