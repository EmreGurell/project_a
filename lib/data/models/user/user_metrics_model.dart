import '../../../domain/entities/user/user_metrics_entity.dart';

class UserMetricsModel extends UserMetricsEntity {
  UserMetricsModel({
    super.age,
    required super.height,
    required super.weight,
    required super.gender,
    required super.goal,
    required super.activityLevel,
    required super.dailyCalorieGoal,
    required super.dailyWaterGoal,
    super.currentStreak,
    super.longestStreak,
  });

  // Parses nested profile object from GET /api/v1/users/me response
  factory UserMetricsModel.fromJson(
    Map<String, dynamic> json, {
    Map<String, dynamic>? streakData,
  }) {
    return UserMetricsModel(
      age: json['age'],
      height: (json['height'] ?? 0).toDouble(),
      weight: (json['weight'] ?? 0).toDouble(),
      gender: json['gender'] ?? '',
      goal: json['goal'] ?? '',
      activityLevel: json['activityLevel'] ?? '',
      dailyCalorieGoal: (json['dailyCalorieGoal'] ?? 0).toDouble(),
      dailyWaterGoal: (json['dailyWaterGoal'] ?? 0).toDouble(),
      currentStreak: streakData?['currentStreak'] ?? 0,
      longestStreak: streakData?['longestStreak'] ?? 0,
    );
  }

  UserMetricsEntity toEntity() {
    return UserMetricsEntity(
      age: age,
      height: height,
      weight: weight,
      gender: gender,
      goal: goal,
      activityLevel: activityLevel,
      dailyCalorieGoal: dailyCalorieGoal,
      dailyWaterGoal: dailyWaterGoal,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
    );
  }
}
