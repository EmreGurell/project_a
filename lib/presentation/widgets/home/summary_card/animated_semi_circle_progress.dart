import 'dart:math';
import 'package:flutter/material.dart';
import 'semi_circle_painter.dart';

class AnimatedSemiCircleProgress extends StatefulWidget {
  const AnimatedSemiCircleProgress({
    super.key,
    required this.progress,
    required this.color,
    required this.center,
    this.size = 140,
    this.strokeWidth = 10,
    this.backgroundColor = Colors.white,
    this.icon,
  });

  final double progress;
  final double size;
  final double strokeWidth;
  final Color color;
  final Color backgroundColor;
  final Widget center;
  final Widget? icon;

  @override
  State<AnimatedSemiCircleProgress> createState() =>
      _AnimatedSemiCircleProgressState();
}

class _AnimatedSemiCircleProgressState extends State<AnimatedSemiCircleProgress>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;

  static const _gapAngle = pi / 2; // painter ile birebir

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.progress.clamp(0.0, 1.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedSemiCircleProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    _animation = Tween<double>(
      begin: _animation.value,
      end: widget.progress.clamp(0.0, 1.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.size / 2;
    final centerX = radius;
    final centerY = radius;

    final startAngle = (pi / 2) + (_gapAngle / 2);
    final sweepAngle = 2 * pi - _gapAngle;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          final angle = startAngle + sweepAngle * _animation.value;
          final iconSize = 28.0;
          final iconRadius = radius + (widget.strokeWidth) - (iconSize / 3);

          final dx = centerX + iconRadius * cos(angle);
          final dy = centerY + iconRadius * sin(angle);

          return Stack(
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: SemiCirclePainter(
                  progress: _animation.value,
                  color: widget.color,
                  strokeWidth: widget.strokeWidth,
                  backgroundColor: widget.backgroundColor,
                ),
              ),

              // center content
              Center(child: widget.center),

              // moving icon
              if (widget.icon != null)
                Positioned(left: dx - 14, top: dy - 14, child: widget.icon!),
            ],
          );
        },
      ),
    );
  }
}
