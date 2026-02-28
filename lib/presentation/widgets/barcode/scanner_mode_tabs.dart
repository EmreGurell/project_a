import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

enum ScanMode { barcode, food, askAI }

class ScannerModeTabs extends StatelessWidget {
  const ScannerModeTabs({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  final ScanMode currentMode;
  final ValueChanged<ScanMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ProjectSizes.pagePadding),
      padding: const EdgeInsets.all(ProjectSizes.borderRadiusSm),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ModeTab(
            icon: PhosphorIconsRegular.barcode,
            label: l10n.scanner_tab_barcode,
            isActive: currentMode == ScanMode.barcode,
            onTap: () => onModeChanged(ScanMode.barcode),
          ),
          const SizedBox(width: ProjectSizes.borderRadiusSm),
          _ModeTab(
            icon: PhosphorIconsRegular.bowlFood,
            label: l10n.scanner_tab_food,
            isActive: currentMode == ScanMode.food,
            onTap: () => onModeChanged(ScanMode.food),
          ),
          const SizedBox(width: ProjectSizes.borderRadiusSm),
          _ModeTab(
            icon: PhosphorIconsRegular.robot,
            label: l10n.scanner_tab_ask_ai,
            isActive: currentMode == ScanMode.askAI,
            onTap: () => onModeChanged(ScanMode.askAI),
          ),
        ],
      ),
    );
  }
}

class _ModeTab extends StatelessWidget {
  const _ModeTab({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.paddingSm + 4,
          vertical: ProjectSizes.paddingSm + 1,
        ),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PhosphorIcon(
              icon,
              size: ProjectSizes.iconSm + 2,
              color: isActive ? ProjectColors.orange : Colors.white70,
            ),
            const SizedBox(width: ProjectSizes.borderRadiusSm + 1),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: isActive ? Colors.black87 : Colors.white70,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
