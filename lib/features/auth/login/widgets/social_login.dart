import 'package:flutter/material.dart';
import 'package:project_a/common/widgets/buttons/google_button.dart';
import 'package:project_a/utils/constants/sizes.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: ProjectSizes.spaceBtwSections),
        GoogleButton(onPressed: () {}),
        const SizedBox(height: 16),
      ],
    );
  }
}
