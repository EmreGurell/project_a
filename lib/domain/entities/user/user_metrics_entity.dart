class UserMetricsEntity {
  final int? age;
  final double height;
  final double weight;
  final String gender;
  final String goal;
  final String activityLevel;
  final double dailyCalorieGoal;
  final double dailyWaterGoal;
  final int currentStreak;
  final int longestStreak;

  UserMetricsEntity({
    this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.goal,
    required this.activityLevel,
    required this.dailyCalorieGoal,
    required this.dailyWaterGoal,
    this.currentStreak = 0,
    this.longestStreak = 0,
  });

  double get bmi {
    if (height <= 0) return 0;
    final heightM = height / 100;
    return weight / (heightM * heightM);
  }
}
