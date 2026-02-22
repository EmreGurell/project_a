import 'package:flutter/material.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/utils/constants/sizes.dart';

import '../../../shared/widgets/buttons/google_button.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: ProjectSizes.spaceBtwSections),
        GoogleButton(onPressed: () {}, text: l10n.continue_with_google),
        const SizedBox(height: 16),
      ],
    );
  }
}
