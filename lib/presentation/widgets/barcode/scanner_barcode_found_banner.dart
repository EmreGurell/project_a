import 'package:flutter/material.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class ScannerBarcodeFoundBanner extends StatelessWidget {
  const ScannerBarcodeFoundBanner({
    super.key,
    required this.barcode,
    required this.onRescan,
  });

  final String barcode;
  final VoidCallback onRescan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Positioned(
      top: MediaQuery.of(context).padding.top + 56,
      left: ProjectSizes.pagePadding,
      right: ProjectSizes.pagePadding,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.paddingMd - 2,
          vertical: ProjectSizes.paddingSm + 2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ProjectSizes.paddingMd - 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: ProjectColors.green,
              size: ProjectSizes.iconM + 2,
            ),
            const SizedBox(width: ProjectSizes.paddingSm + 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.scanner_barcode_found,
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    barcode,
                    style: textTheme.bodySmall?.copyWith(
                      color: ProjectColors.textGray,
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onRescan,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: ProjectSizes.paddingSm + 2,
                  vertical: ProjectSizes.borderRadiusSm + 1,
                ),
                decoration: BoxDecoration(
                  color: ProjectColors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusMd),
                ),
                child: Text(
                  l10n.scanner_barcode_rescan,
                  style: textTheme.bodySmall?.copyWith(
                    color: ProjectColors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
