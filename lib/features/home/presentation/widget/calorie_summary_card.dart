import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:project_a/utils/constants/colors.dart';

class CalorieSummaryCard extends StatelessWidget {
  const CalorieSummaryCard({
    super.key,
    this.calories = 1345,
    this.calorieProgress = 0.65,
    this.carbProgress = 0.72,
    this.proteinProgress = 0.58,
    this.fatProgress = 0.38,
  });

  final int calories;
  final double calorieProgress;
  final double carbProgress;
  final double proteinProgress;
  final double fatProgress;

  static const Color _cardBackground = Color(0xFFBCE7F0);
  static const Color _trackColor = Color(0xFFD3C4EF);
  static const Color _carbColor = Color(0xFFE8A87C);
  static const Color _proteinColor = Color(0xFF7FDBB0);
  static const Color _fatColor = Color(0xFFF7E4A9);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: Border.all(
          color: ProjectColors.secondaryCardBlue.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _MacroProgressSection(
              carbProgress: carbProgress,
              proteinProgress: proteinProgress,
              fatProgress: fatProgress,
            ),
          ),
          const SizedBox(width: 16),
          _CalorieCircleSection(calories: calories, progress: calorieProgress),
        ],
      ),
    );
  }
}

class _MacroProgressSection extends StatelessWidget {
  const _MacroProgressSection({
    required this.carbProgress,
    required this.proteinProgress,
    required this.fatProgress,
  });

  final double carbProgress;
  final double proteinProgress;
  final double fatProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _MacroBar(
          label: 'Karbonhidrat',
          progress: carbProgress,
          color: CalorieSummaryCard._carbColor,
        ),
        const SizedBox(height: 14),
        _MacroBar(
          label: 'Protein',
          progress: proteinProgress,
          color: CalorieSummaryCard._proteinColor,
        ),
        const SizedBox(height: 14),
        _MacroBar(
          label: 'Yağ',
          progress: fatProgress,
          color: CalorieSummaryCard._fatColor,
        ),
      ],
    );
  }
}

class _MacroBar extends StatelessWidget {
  const _MacroBar({
    required this.label,
    required this.progress,
    required this.color,
  });

  final String label;
  final double progress;
  final Color color;

  static const Color _trackColor = Color(0xFFF0F0F0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        LinearPercentIndicator(
          lineHeight: 8,
          percent: progress.clamp(0.0, 1.0),
          backgroundColor: _trackColor,
          progressColor: color,
          barRadius: const Radius.circular(4),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

class _CalorieCircleSection extends StatelessWidget {
  const _CalorieCircleSection({required this.calories, required this.progress});

  final int calories;
  final double progress;

  static const Color _progressColor = Color(0xFFD3C4EF);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        CircularPercentIndicator(
          radius: 56,
          lineWidth: 10,
          percent: progress.clamp(0.0, 1.0),
          backgroundColor: ProjectColors.white,
          progressColor: _progressColor,
          circularStrokeCap: CircularStrokeCap.round,
          center: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$calories',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Kalori',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: ProjectColors.yellow,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Icon(
              Icons.graphic_eq_rounded,
              size: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
