import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/constants/texts.dart';
import 'package:project_a/utils/themes/custom_themes/text_theme.dart';

import '../../../shared/widgets/buttons/3d_button.dart';

class AdditionalInfoSheet extends StatelessWidget {
  final String title;
  final String description;

  const AdditionalInfoSheet({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.pagePadding,
          vertical: ProjectSizes.pagePadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: ProjectSizes.sheetHandleWidth,
                height: ProjectSizes.sheetHandleHeight,
                margin: const EdgeInsets.only(
                  bottom: ProjectSizes.sheetHandleBottom,
                ),
                decoration: BoxDecoration(
                  color: ProjectColors.gray,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Text(title, style: Theme.of(context).textTheme.title),
            const SizedBox(height: ProjectSizes.paddingSm),
            Text(
              description,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(color: ProjectColors.textGray),
            ),
            const SizedBox(height: ProjectSizes.paddingMd),
            SizedBox(
              width: double.infinity,
              child: Button3D(
                text: ProjectTexts.formInfoAcknowledge,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
