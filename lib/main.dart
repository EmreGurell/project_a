import 'package:flutter/material.dart';
import 'package:project_a/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:project_a/utils/themes/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: OnboardingScreen(),
    );
  }
}
