import 'package:flutter/material.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/utils/constants/sizes.dart';

class ScannerFoodFrameOverlay extends StatelessWidget {
  const ScannerFoodFrameOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    final frameSize = screenSize.width * 0.72;
    final top = (screenSize.height - frameSize) / 2 - 20;
    final left = (screenSize.width - frameSize) / 2;

    return Positioned(
      top: top,
      left: left,
      width: frameSize,
      height: frameSize,
      child: IgnorePointer(
        child: CustomPaint(
          painter: _FoodCornerPainter(),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.restaurant_menu,
                  color: Colors.white.withOpacity(0.25),
                  size: 48,
                ),
                const SizedBox(height: ProjectSizes.paddingSm),
                Text(
                  l10n.scanner_food_align,
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FoodCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.85)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const len = 36.0;
    const r = 8.0;

    canvas.drawLine(const Offset(0, len), const Offset(0, r), paint);
    canvas.drawArc(const Rect.fromLTWH(0, 0, r * 2, r * 2), 3.14, 1.57, false, paint);
    canvas.drawLine(const Offset(r, 0), Offset(len, 0), paint);

    canvas.drawLine(Offset(size.width - len, 0), Offset(size.width - r, 0), paint);
    canvas.drawArc(Rect.fromLTWH(size.width - r * 2, 0, r * 2, r * 2), -1.57, 1.57, false, paint);
    canvas.drawLine(Offset(size.width, r), Offset(size.width, len), paint);

    canvas.drawLine(Offset(size.width, size.height - len), Offset(size.width, size.height - r), paint);
    canvas.drawArc(Rect.fromLTWH(size.width - r * 2, size.height - r * 2, r * 2, r * 2), 0, 1.57, false, paint);
    canvas.drawLine(Offset(size.width - r, size.height), Offset(size.width - len, size.height), paint);

    canvas.drawLine(Offset(len, size.height), Offset(r, size.height), paint);
    canvas.drawArc(Rect.fromLTWH(0, size.height - r * 2, r * 2, r * 2), 1.57, 1.57, false, paint);
    canvas.drawLine(Offset(0, size.height - r), Offset(0, size.height - len), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
