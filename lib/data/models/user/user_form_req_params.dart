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

  static List<String> _parseMultiSelect(String? value) {
    if (value == null || value.isEmpty) return [];
    return value.split(',').where((s) => s.isNotEmpty).toList();
  }

  factory UserFormReqParams.fromFormAnswers(Map<String, String> answers) {
    return UserFormReqParams(
      username: answers['username'],
      gender: answers['gender'],
      goal: answers['goal'],
      age: answers['age'] != null ? int.tryParse(answers['age']!) : null,
      height: answers['height'] != null ? double.tryParse(answers['height']!) : null,
      weight: answers['weight'] != null ? double.tryParse(answers['weight']!) : null,
      activityLevel: answers['activityLevel'],
      allergies: _parseMultiSelect(answers['allergies']),
      healthConditions: _parseMultiSelect(answers['healthConditions']),
    );
  }
}
