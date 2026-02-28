class AiNutritionResultModel {
  final String name;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double? fiber;
  final String? portionSize;

  const AiNutritionResultModel({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.fiber,
    this.portionSize,
  });

  factory AiNutritionResultModel.fromJson(Map<String, dynamic> json) {
    // Turkish API response: { analiz: { toplam_kalori, toplam_makro: { karbonhidrat, protein, yag } }, besinler: [...] }
    final analiz = json['analiz'] as Map<String, dynamic>?;
    if (analiz != null) {
      final makro = analiz['toplam_makro'] as Map<String, dynamic>? ?? {};
      final besinler = json['besinler'] as List<dynamic>?;
      String name = '';
      if (besinler != null && besinler.isNotEmpty) {
        final first = besinler.first as Map<String, dynamic>;
        name = (first['ad'] ?? first['isim'] ?? first['name'] ?? '').toString();
      }
      return AiNutritionResultModel(
        name: name,
        calories: _d(analiz['toplam_kalori']),
        protein: _d(makro['protein']),
        carbs: _d(makro['karbonhidrat']),
        fat: _d(makro['yag']),
        fiber: _dNull(makro['lif']),
        portionSize: analiz['referans_dogrulama']?.toString(),
      );
    }

    // Fallback: English/generic structure
    final inner = json['nutrition'] as Map<String, dynamic>? ?? json;
    return AiNutritionResultModel(
      name: (inner['name'] ?? json['name'] ?? '')?.toString() ?? '',
      calories: _d(inner['calories'] ?? inner['kcal'] ?? json['calories'] ?? 0),
      protein: _d(inner['protein'] ?? json['protein'] ?? 0),
      carbs: _d(inner['carbs'] ?? inner['carbohydrates'] ?? json['carbs'] ?? 0),
      fat: _d(inner['fat'] ?? json['fat'] ?? 0),
      fiber: _dNull(inner['fiber'] ?? json['fiber']),
      portionSize: (inner['portionSize'] ?? json['portionSize'] ?? inner['portion_size'])?.toString(),
    );
  }

  static double _d(dynamic v) {
    if (v == null) return 0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }

  static double? _dNull(dynamic v) => v == null ? null : _d(v);
}
