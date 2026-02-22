import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/themes/custom_themes/text_field_theme.dart';
import 'package:project_a/utils/themes/custom_themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: ProjectColors.orange,
    scaffoldBackgroundColor: ProjectColors.white,
    textTheme: ProjectTextTheme.lightTextTheme,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    // chipTheme: CustomChipTheme.lightChipThemeData,
    // appBarTheme: CustomAppBarTheme.lightAppBarTheme,
     elevatedButtonTheme: ElevatedButtonThemeData(
       style: ButtonStyle(
         overlayColor: WidgetStateProperty.all(Colors.transparent),
         splashFactory: NoSplash.splashFactory,
       ),),
    inputDecorationTheme: ProjectTextFieldTheme.lightTextFieldTheme,
    // bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetThemeTheme,
    //checkboxTheme: CustomCheckboxTheme.lightCheckboxTheme,
    //outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
  );
  // static ThemeData darkTheme = ThemeData(
  //   useMaterial3: true,
  //   fontFamily: 'Poppins',
  //   brightness: Brightness.dark,
  //   primaryColor: ProjectColors.orange,
  //   scaffoldBackgroundColor: ProjectColors.white,
  //   textTheme: CustomTextTheme.darkTextTheme,
  //   // chipTheme: CustomChipTheme.darkChipThemeData,
  //   appBarTheme: CustomAppBarTheme.darkAppBarTheme,
  //   elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
  //   inputDecorationTheme: CustomTextFieldTheme.darkTextFieldTheme,
  //   bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetThemeTheme,
  //   checkboxTheme: CustomCheckboxTheme.darkCheckboxTheme,
  //   outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
  // );
}
