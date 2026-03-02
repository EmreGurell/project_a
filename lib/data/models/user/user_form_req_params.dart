class UserFormReqParams {
  final String? username;
  final int? age;
  final double? height;
  final double? weight;
  final String? gender;
  final String? goal;
  final String? activityLevel;
  final String dietaryPreference;
  final List<String> allergies;
  final List<String> healthConditions;

  const UserFormReqParams({
    this.username,
    this.age,
    this.height,
    this.weight,
    this.gender,
    this.goal,
    this.activityLevel,
    this.dietaryPreference = 'omnivore',
    this.allergies = const [],
    this.healthConditions = const [],
  });

  Map<String, dynamic> toJson() => {
        if (username != null) 'username': username,
        if (age != null) 'age': age,
        if (height != null) 'height': height,
        if (weight != null) 'weight': weight,
        if (gender != null) 'gender': gender,
        if (goal != null) 'goal': goal,
        if (activityLevel != null) 'activityLevel': activityLevel,
        'dietaryPreference': dietaryPreference,
        'allergies': allergies,
        'healthConditions': healthConditions,
      };

  // Turkish form choices → API values (FRONTEND.md)
  static String mapGender(String tr) {
    switch (tr) {
      case 'Erkek':
        return 'male';
      case 'Kadın':
        return 'female';
      default:
        return 'other';
    }
  }

  static String mapGoal(String tr) {
    switch (tr) {
      case 'Kilo vermek':
        return 'lose_weight';
      case 'Kilo almak':
        return 'gain_muscle';
      case 'Mevcut kiloyu korumak':
        return 'maintain';
      case 'Kas Yapmak':
        return 'gain_muscle';
      default:
        return 'maintain';
    }
  }

  static String mapActivityLevel(String tr) {
    switch (tr) {
      case 'Hareketsiz':
        return 'sedentary';
      case 'Az Aktif':
        return 'light';
      case 'Orta Aktif':
        return 'moderate';
      case 'Çok Aktif':
        return 'active';
      default:
        return 'sedentary';
    }
  }

  static List<String> _parseMultiSelect(String? value) {
    if (value == null || value.isEmpty) return [];
    return value.split(',').where((s) => s.isNotEmpty).toList();
  }

  factory UserFormReqParams.fromFormAnswers(Map<String, String> answers) {
    return UserFormReqParams(
      username: answers['username'],
      gender: answers['gender'] != null ? mapGender(answers['gender']!) : null,
      goal: answers['goal'] != null ? mapGoal(answers['goal']!) : null,
      age: answers['age'] != null ? int.tryParse(answers['age']!) : null,
      height: answers['height'] != null ? double.tryParse(answers['height']!) : null,
      weight: answers['weight'] != null ? double.tryParse(answers['weight']!) : null,
      activityLevel: answers['activityLevel'] != null
          ? mapActivityLevel(answers['activityLevel']!)
          : null,
      allergies: _parseMultiSelect(answers['allergies']),
      healthConditions: _parseMultiSelect(answers['healthConditions']),
    );
  }
}
