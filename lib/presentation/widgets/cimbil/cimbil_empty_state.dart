import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/presentation/widgets/cimbil/cimbil_suggestion_chip.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class CimbilEmptyState extends StatelessWidget {
  const CimbilEmptyState({super.key, required this.onSuggestionTap});
  final ValueChanged<String> onSuggestionTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.paddingLg * 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ProjectColors.orange.withOpacity(0.15),
                    const Color(0xFFFF6B6B).withOpacity(0.1),
                  ],
                ),
              ),
              child: PhosphorIcon(
                PhosphorIconsRegular.robot,
                size: 40,
                color: ProjectColors.orange,
              ),
            ),
            const SizedBox(height: ProjectSizes.pagePadding),
            Text(
              l10n.cimbil_greeting,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: ProjectSizes.paddingSm),
            Text(
              l10n.cimbil_description,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: ProjectColors.textGray,
                height: 1.5,
              ),
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems * 2),
            Wrap(
              spacing: ProjectSizes.paddingSm,
              runSpacing: ProjectSizes.paddingSm,
              alignment: WrapAlignment.center,
              children: [
                CimbilSuggestionChip(
                  label: l10n.cimbil_suggestion_calorie,
                  onTap: () => onSuggestionTap(l10n.cimbil_query_calorie),
                ),
                CimbilSuggestionChip(
                  label: l10n.cimbil_suggestion_recipe,
                  onTap: () => onSuggestionTap(l10n.cimbil_query_recipe),
                ),
                CimbilSuggestionChip(
                  label: l10n.cimbil_suggestion_protein,
                  onTap: () => onSuggestionTap(l10n.cimbil_query_protein),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
