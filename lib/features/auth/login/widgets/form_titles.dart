import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/constants/texts.dart';
import 'package:project_a/utils/themes/custom_themes/text_theme.dart';

class FormTitles extends StatelessWidget {
  const FormTitles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: ProjectSizes.spaceBtwSections),
        Text(ProjectTexts.loginTitle, style: Theme.of(context).textTheme.title),
        const SizedBox(height: ProjectSizes.spaceBtwItems / 8),
        Text(
          ProjectTexts.loginSubtitle,
          style: Theme.of(context).textTheme.sectionHeadingDesc,
        ),
        const SizedBox(height: ProjectSizes.spaceBtwSections),
      ],
    );
  }
}
