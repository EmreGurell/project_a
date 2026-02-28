import 'package:flutter/material.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/utils/constants/sizes.dart';

class ScannerScanOverlay extends StatelessWidget {
  const ScannerScanOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 260,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ProjectSizes.pagePadding),
              border: Border.all(
                color: Colors.white.withOpacity(0.7),
                width: 2.5,
              ),
            ),
          ),
          const SizedBox(height: ProjectSizes.paddingMd),
          Text(
            l10n.scanner_barcode_align,
            style: textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
