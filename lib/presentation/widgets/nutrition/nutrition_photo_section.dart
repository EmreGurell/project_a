import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class NutritionPhotoSection extends StatelessWidget {
  const NutritionPhotoSection({super.key, required this.photoPath});
  final String photoPath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 260,
        height: 260,
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ProjectSizes.pagePadding),
                child: Image.file(
                  File(photoPath),
                  width: 230,
                  height: 230,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      color: ProjectColors.cardGray,
                      borderRadius: BorderRadius.circular(ProjectSizes.pagePadding),
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      size: 60,
                      color: ProjectColors.textGray,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(top: 0, left: 0, child: _Corner(rotation: 0)),
            const Positioned(top: 0, right: 0, child: _Corner(rotation: 1)),
            const Positioned(bottom: 0, right: 0, child: _Corner(rotation: 2)),
            const Positioned(bottom: 0, left: 0, child: _Corner(rotation: 3)),
          ],
        ),
      ),
    );
  }
}

class _Corner extends StatelessWidget {
  const _Corner({required this.rotation});
  final int rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation * pi / 2,
      child: CustomPaint(
        size: const Size(30, 30),
        painter: _CornerPainter(),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, size.height * 0.5), const Offset(0, 0), paint);
    canvas.drawLine(const Offset(0, 0), Offset(size.width * 0.5, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
