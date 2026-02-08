import 'package:flutter/material.dart';

class WaterIntakeCard extends StatelessWidget {
  const WaterIntakeCard({
    super.key,
    this.currentGlasses = 9,
    this.dailyGoalGlasses = 12,
    this.waterGlassAsset =
        'assets/images/water_glass.png', // Dummy image buraya gelecek
  });

  final int currentGlasses;
  final int dailyGoalGlasses;
  final String waterGlassAsset;

  // Tasarımdaki renkler
  static const Color _cardBackground = Color(0xFFE1F3FE);
  static const Color _activeBlue = Color(0xFF3A82F7);
  static const Color _emptyBar = Colors.white;

  @override
  Widget build(BuildContext context) {
    // Toplam 6 adet dikey bar olduğunu varsayıyoruz (görsele göre)
    const int totalSegments = 6;
    double progressRatio = (currentGlasses / dailyGoalGlasses).clamp(0.0, 1.0);
    double filledSegments = progressRatio * totalSegments;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ), // Görseldeki yumuşak köşeler
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                waterGlassAsset,
                width: 60,
                fit: BoxFit.contain,
                // Resim yoksa gösterilecek placeholder
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.water_drop, color: _activeBlue, size: 30),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'ilerlemen',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  '$currentGlasses/$dailyGoalGlasses',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Sağ taraf: Özel Segmentli İlerleme Çubuğu
          Row(
            children: List.generate(totalSegments, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildVerticalBar(index, filledSegments),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Dikey barları oluşturan yardımcı fonksiyon
  Widget _buildVerticalBar(int index, double filledSegments) {
    double fillLevel = 0.0;

    if (index < filledSegments.floor()) {
      fillLevel = 1.0; // Tam dolu
    } else if (index == filledSegments.floor()) {
      fillLevel = filledSegments - filledSegments.floor(); // Kısmi dolu
    }

    return Container(
      width: 14,
      height: 40,
      decoration: BoxDecoration(
        color: _emptyBar,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: fillLevel,
        child: Container(
          decoration: BoxDecoration(
            color: _activeBlue,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
