import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:project_a/utils/themes/custom_themes/text_theme.dart';

class ProjectTextFieldTheme {
  ProjectTextFieldTheme._();

  static InputDecorationTheme lightTextFieldTheme = InputDecorationTheme(
    errorMaxLines: 3,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    prefixIconColor: ProjectColors.gray,
    suffixIconColor: ProjectColors.textGray,

    filled: true,
    fillColor: Colors.white,
    labelStyle: ProjectTextTheme.lightTextTheme.labelSmall!.copyWith(
      color: ProjectColors.textGray,
    ),
    hintStyle: ProjectTextTheme.lightTextTheme.labelSmall!.copyWith(
      color: ProjectColors.textGray,
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: ProjectTextTheme.lightTextTheme.labelMedium!.copyWith(
      color: Colors.black,
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusMd),
      borderSide: const BorderSide(width: 1, color: ProjectColors.gray),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusMd),
      borderSide: const BorderSide(width: 1, color: ProjectColors.gray),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusMd),
      borderSide: const BorderSide(width: 1, color: ProjectColors.orange),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusMd),
      borderSide: const BorderSide(width: 1, color: ProjectColors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ProjectSizes.borderRadiusMd),
      borderSide: const BorderSide(width: 1, color: ProjectColors.red),
    ),
  );
}
