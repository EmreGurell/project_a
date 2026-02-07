import 'package:flutter/material.dart';

class ProjectTextTheme {
  ProjectTextTheme._();

  static const TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),

    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ), // Login/Register butonları için
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ), // Calendar pzt,sal vs. yazıları için
    labelSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ), //İnput field yazıları için
  );
}

extension TextThemeAliases on TextTheme {
  TextStyle get appBarText => headlineLarge ?? const TextStyle();
  TextStyle get sectionHeadingTitle => headlineMedium ?? const TextStyle();
  TextStyle get sectionHeadingDesc => headlineSmall ?? const TextStyle();
  TextStyle get title => bodyLarge ?? const TextStyle();
}
