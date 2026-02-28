import 'package:flutter/material.dart';

class NutritionMacro {
  final String name;
  final int grams;
  final int dailyTarget;
  final Color color;

  const NutritionMacro({
    required this.name,
    required this.grams,
    required this.dailyTarget,
    required this.color,
  });

  double get progress => (grams / dailyTarget).clamp(0.0, 1.0);
}
