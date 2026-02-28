import 'package:flutter/material.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class ScannerQueryingModal extends StatelessWidget {
  const ScannerQueryingModal({super.key, required this.barcode});
  final String barcode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: ProjectSizes.paddingLg + 16),
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.paddingLg + 4,
          vertical: ProjectSizes.spaceBtwSections,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ProjectSizes.paddingLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 44,
              height: 44,
              child: CircularProgressIndicator(
                strokeWidth: 3.5,
                color: ProjectColors.orange,
              ),
            ),
            const SizedBox(height: ProjectSizes.pagePadding),
            Text(
              l10n.scanner_querying,
              style: textTheme.titleLarge?.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: ProjectSizes.paddingSm),
            Text(
              barcode,
              style: textTheme.bodySmall?.copyWith(
                color: ProjectColors.textGray,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ProjectSizes.paddingSm - 2),
            Text(
              l10n.scanner_querying_detail,
              style: textTheme.bodySmall?.copyWith(
                color: ProjectColors.textGray.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
