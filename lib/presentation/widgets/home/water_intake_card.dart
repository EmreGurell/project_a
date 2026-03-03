import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/presentation/bloc/home/home_bloc.dart';
import 'package:project_a/presentation/bloc/home/home_event.dart';
import 'package:project_a/utils/constants/sizes.dart';

class WaterIntakeCard extends StatefulWidget {
  const WaterIntakeCard({
    super.key,
    required this.currentGlasses,
    this.dailyGoalGlasses = 12,
    this.totalBars = 6,
    this.waterGlassAsset = 'assets/images/water_glass.png',
  });

  final int currentGlasses;
  final int dailyGoalGlasses;
  final int totalBars;
  final String waterGlassAsset;

  @override
  State<WaterIntakeCard> createState() => _WaterIntakeCardState();
}

class _WaterIntakeCardState extends State<WaterIntakeCard>
    with SingleTickerProviderStateMixin {
  static const Color _cardBackground = Color(0xFFE1F3FE);
  static const Color _activeBlue = Color(0xFF3A82F7);

  late final AnimationController _bounceController;
  late final Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _bounceAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.25), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.25, end: 0.9), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _bounceController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _onIconTap() {
    if (widget.currentGlasses >= widget.dailyGoalGlasses) return;
    _bounceController.forward(from: 0);
    context.read<HomeBloc>().add(IncrementWater());
  }

  void _onIconLongPress() {
    if (widget.currentGlasses == 0) return;
    for (var i = 0; i < widget.currentGlasses; i++) {
      context.read<HomeBloc>().add(DecrementWater());
    }
  }

  /// Her bar için doluluk oranı: 0.0, 0.5 veya 1.0
  double _barFill(int barIndex) {
    // Her bar kaç tıklamaya karşılık gelir
    final tapsPerBar = widget.dailyGoalGlasses / widget.totalBars; // 2.0
    final barStart = barIndex * tapsPerBar;       // 0, 2, 4, 6, 8, 10
    final barEnd = barStart + tapsPerBar;          // 2, 4, 6, 8, 10, 12

    final glasses = widget.currentGlasses.toDouble();
    if (glasses >= barEnd) return 1.0;
    if (glasses <= barStart) return 0.0;
    return (glasses - barStart) / tapsPerBar;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ProjectSizes.pagePadding,
        vertical: ProjectSizes.pagePadding / 1.5,
      ),
      decoration: const BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          // Sol: bounce animasyonlu ikon
          GestureDetector(
            onTap: _onIconTap,
            onLongPress: _onIconLongPress,
            child: ScaleTransition(
              scale: _bounceAnimation,
              child: Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    widget.waterGlassAsset,
                    width: 32,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.water_drop,
                      color: _activeBlue,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Orta: label + sayaç
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.home_water_progress,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${widget.currentGlasses} / ${widget.dailyGoalGlasses}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Sağ: 6 bar, her biri 2 tıklama = yarım + tam dolu
          Row(
            children: List.generate(widget.totalBars, (index) {
              final fill = _barFill(index);
              return GestureDetector(
                onTap: () {
                  // Tıklanan barın başlangıç tıklaması
                  final tapsPerBar = widget.dailyGoalGlasses / widget.totalBars;
                  final targetTap = ((index + 1) * tapsPerBar).toInt();
                  final diff = targetTap - widget.currentGlasses;
                  if (diff > 0) {
                    for (var i = 0; i < diff; i++) {
                      context.read<HomeBloc>().add(IncrementWater());
                    }
                    _bounceController.forward(from: 0);
                  } else if (diff < 0) {
                    for (var i = 0; i < diff.abs(); i++) {
                      context.read<HomeBloc>().add(DecrementWater());
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: _AnimatedBar(fill: fill),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _AnimatedBar extends StatelessWidget {
  const _AnimatedBar({required this.fill});
  final double fill; // 0.0, 0.5, 1.0

  static const Color _activeBlue = Color(0xFF3A82F7);
  static const Color _halfBlue = Color(0xFF8DB8F5);
  static const Color _emptyGlass = Color(0xFFB8DCF8);

  @override
  Widget build(BuildContext context) {
    final Color color = fill >= 1.0
        ? _activeBlue
        : fill >= 0.5
            ? _halfBlue
            : _emptyGlass;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 14,
      height: 36,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      // Yarım doluluk için alt kısım dolu görünümü
      child: fill > 0.0 && fill < 1.0
          ? Column(
              children: [
                Expanded(flex: (10 - (fill * 10).round()), child: const SizedBox()),
                Expanded(
                  flex: (fill * 10).round(),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: const BoxDecoration(
                      color: _activeBlue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
