import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/image_paths.dart';
import 'package:project_a/utils/constants/sizes.dart';

/// A Google sign-in styled button matching the provided design.
///
/// Usage:
/// ```dart
/// GoogleButton(onPressed: () { /* sign-in */ });
/// ```
class GoogleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double height;
  final bool expand;

  const GoogleButton({
    Key? key,
    this.onPressed,
    this.text = 'Google ile Giriş Yap',
    this.height = 48.0,
    this.expand = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = ProjectColors.googleButtonBlue;
    final borderColor = ProjectColors.buttonGray;

    Widget logo = Image.asset(
      ImageAndAnimationPaths.googleLogo,
      width: 24,
      height: 24,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const FlutterLogo(size: 24),
    );

    final buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 36, height: 36, child: Center(child: logo)),
        const SizedBox(width: 12),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.labelLarge!.copyWith(color: textColor),
        ),
      ],
    );

    final button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 1,
        padding: EdgeInsets.zero,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusMd),
          side: BorderSide(color: borderColor, width: 2),
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: height,
        child: Center(child: buttonChild),
      ),
    );

    if (expand) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
